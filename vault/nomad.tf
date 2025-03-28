resource "vault_jwt_auth_backend" "jwt" {
  type               = "jwt"
  path               = "jwt-nomad"
  jwks_url           = "http://${var.nomad_ip}:4646/.well-known/jwks.json"
  jwt_supported_algs = ["RS256", "EdDSA"]
  default_role       = "nomad-workloads"
}

resource "vault_jwt_auth_backend_role" "nomad_workloads" {
  backend                 = vault_jwt_auth_backend.jwt.path
  role_name               = "nomad-workloads"
  role_type               = "jwt"
  bound_audiences         = ["vault.io"]
  user_claim              = "/nomad_job_id"
  user_claim_json_pointer = true
  claim_mappings = {
    nomad_namespace = "nomad_namespace"
    nomad_job_id    = "nomad_job_id"
    nomad_task      = "nomad_task"
  }
  token_type             = "service"
  token_policies         = ["nomad-workloads"]
  token_period           = 1800
  token_explicit_max_ttl = 0
}

resource "vault_mount" "kv" {
  path = "kv"
  type = "kv"
  options = {
    version = "2"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "vault_policy" "nomad_workloads" {
  name = "nomad-workloads"

  policy = <<EOT
path "kv/data/{{identity.entity.aliases.${vault_jwt_auth_backend.jwt.accessor}.metadata.nomad_namespace}}/{{identity.entity.aliases.${vault_jwt_auth_backend.jwt.accessor}.metadata.nomad_job_id}}/*" {
  capabilities = ["read"]
}
path "kv/data/{{identity.entity.aliases.${vault_jwt_auth_backend.jwt.accessor}.metadata.nomad_namespace}}/{{identity.entity.aliases.${vault_jwt_auth_backend.jwt.accessor}.metadata.nomad_job_id}}" {
  capabilities = ["read"]
}
path "kv/metadata/{{identity.entity.aliases.${vault_jwt_auth_backend.jwt.accessor}.metadata.nomad_namespace}}/*" {
  capabilities = ["list"]
}
path "kv/metadata/*" {
  capabilities = ["list"]
}
EOT
}