# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is an infrastructure-as-code repository managing a homelab environment with HashiCorp Nomad, Vault, and various services. The infrastructure uses Terraform for provisioning, Ansible for server configuration, and HCL templates for Nomad job definitions.

## Architecture

### Multi-Environment Setup

The repository supports multiple environments (test, live) with environment-specific configurations:
- Environment configs are in `<app>/{test,live}.tfvars` files
- Terraform state is stored locally in `<app>/{test,live}/terraform.tfstate`
- Each app directory (nomad, vault, adguard, dsm) is an independent Terraform root module

### Core Infrastructure Stack

**Vault** (vault/):
- Manages PKI infrastructure with root CA and intermediate CA
- Provides ACME server for automatic certificate issuance
- JWT auth backend for Nomad workload identity
- KV secrets engine (v2) for application configuration
- Database credentials engine for dynamic database access
- Root CA certificates are in local/ directory and referenced by both vault/ and nomad/ modules

**Nomad** (nomad/):
- Orchestrates containerized services using Podman driver
- Job definitions are HCL templates in nomad/jobs/ directory
- Services use Vault integration for secrets and dynamic database credentials
- Traefik serves as reverse proxy with automatic HTTPS via ACME
- ACL policies and tokens are managed for service authentication

**Service Integration Pattern**:
Services deployed to Nomad typically:
1. Use `vault {}` block to enable Vault integration with JWT auth
2. Fetch secrets via `template {}` blocks from `kv/data/default/<job-name>/config`
3. Get dynamic database credentials from `database/creds/<job-name>`
4. Register with Nomad service discovery and expose Traefik tags for routing
5. Use host networking mode with static ports

### Shared Infrastructure Services

**Postgres** (nomad/jobs/postgres.hcl.tmpl):
- Shared PostgreSQL instance for multiple applications
- Accessed via localhost from co-located services

**Redis** (nomad/jobs/redis.hcl.tmpl):
- Shared Redis instance for queue-based applications
- Accessed via localhost from co-located services

### Example: n8n High-Availability Setup

The n8n service demonstrates a multi-group job pattern:
- Main group (n8n-main): Runs the web UI and API (count=1)
- Worker group (n8n-workers): Executes workflows from Redis queue (count=2)
- Both groups share database (Postgres) and queue (Redis) via localhost
- Workers use queue mode with `EXECUTIONS_MODE=queue` and `QUEUE_WORKER_CONCURRENCY=10`
- Health checks on dedicated ports for each service type

## Common Commands

### Terraform Operations

All Terraform commands use the Makefile with required `env` and `app` parameters:

```bash
# Initialize Terraform for an app/environment
make init env=test app=nomad

# Plan changes
make plan env=test app=vault

# Apply changes
make apply env=live app=nomad

# Format and validate
make fmt env=test app=nomad

# Destroy resources
make destroy env=test app=adguard
```

### Ansible Operations

```bash
# Deploy Nomad servers
ansible-playbook -i test.hosts nomad.yml

# Initialize Vault
ansible-playbook -i live.hosts vault.yml

# Unseal Vault
ansible-playbook -i test.hosts vault-unseal.yml
```

## Key Files and Patterns

### Terraform Module Structure

Each app directory follows this pattern:
```
<app>/
├── main.tf           # Primary resources
├── variables.tf      # Variable declarations
├── versions.tf       # Provider configuration
├── test.tfvars       # Test environment values
├── live.tfvars       # Production environment values
├── test/             # Test environment state
└── live/             # Production environment state
```

### Nomad Job Templates

Job files in nomad/jobs/ use `.hcl.tmpl` extension and are processed by Terraform's `templatefile()` function. Variables are injected from nomad/main.tf resource definitions.

Common template variables:
- `version`: Container image tag
- `hostname`: FQDN for Traefik routing
- Additional service-specific variables as needed

### Vault Policies

Vault policies use identity templating to scope access by Nomad job:
- `{{identity.entity.aliases.<accessor>.metadata.nomad_namespace}}`
- `{{identity.entity.aliases.<accessor>.metadata.nomad_job_id}}`
- `{{identity.entity.aliases.<accessor>.metadata.nomad_task}}`

This allows job-specific secrets at paths like `kv/data/default/<job-name>/config`.

## Important Notes

### Certificate Management

- Root CA is self-signed and stored in local/ directory
- Vault PKI provides intermediate CA signed by root CA
- Vault ACME server issues certificates for services
- Root CA certificate must be trusted by clients for HTTPS
- Traefik uses ACME resolver configured in nomad/jobs/traefik.hcl.tmpl

### State Files

- Terraform state files are NOT in .gitignore for test/live directories (tracked in git)
- This is intentional for this homelab environment
- The backend is configured as "local" in versions.tf files

### Nomad Job Modifications

When modifying Nomad jobs:
1. Edit the .hcl.tmpl file in nomad/jobs/
2. Update the corresponding resource in nomad/main.tf if template variables changed
3. Run `make plan env=<env> app=nomad` to see changes
4. Apply with `make apply env=<env> app=nomad`

### Adding New Services

To add a new service to Nomad:
1. Create job template in nomad/jobs/<service>.hcl.tmpl
2. Add `nomad_job` resource in nomad/main.tf
3. Add hostname variable in nomad/variables.tf
4. Set hostname value in nomad/{test,live}.tfvars
5. Create Vault secrets at `kv/data/default/<service>/config` if needed
6. If database required, configure role in Vault database engine
