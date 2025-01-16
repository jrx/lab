resource "nomad_job" "adguard" {
  jobspec = templatefile(
    "${path.module}/jobs/adguard.hcl.tmpl", {
      version = "latest",
  })
}

resource "nomad_job" "vault" {
  jobspec = templatefile(
    "${path.module}/jobs/vault.hcl.tmpl", {
      version = "latest",
  })
}

resource "nomad_job" "vault-unsealer" {
  jobspec = file(
  "${path.module}/jobs/vault-unsealer.hcl.tmpl")
}

resource "nomad_job" "http-echo" {
  jobspec = file(
  "${path.module}/jobs/http-echo.hcl.tmpl")
}

resource "nomad_acl_policy" "traefik_policy" {
  name        = "traefik-policy"
  description = "Policy for Traefik with read-job permission"
  rules_hcl   = <<EOT
namespace "default" {
  policy = "read"
  capabilities = ["read-job"]
}
EOT
}

resource "nomad_acl_token" "traefik_token" {
  name     = "traefik-token"
  type     = "client"
  policies = [nomad_acl_policy.traefik_policy.name]
}

resource "nomad_job" "traefik" {
  jobspec = templatefile(
    "${path.module}/jobs/traefik.hcl.tmpl", {
      token = nomad_acl_token.traefik_token.secret_id,
  })
}