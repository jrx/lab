resource "nomad_job" "adguard" {
  jobspec = templatefile(
    "${path.module}/jobs/adguard.hcl.tmpl", {
      version  = "latest",
      hostname = var.adguard_host
  })
}

resource "nomad_job" "it-tools" {
  jobspec = templatefile(
    "${path.module}/jobs/it-tools.hcl.tmpl", {
      version  = "latest",
      hostname = var.it-tools_host
  })
}

resource "nomad_job" "glance" {
  jobspec = file(
  "${path.module}/jobs/glance.hcl.tmpl")
}

resource "nomad_job" "ente_export" {
  jobspec = file(
  "${path.module}/jobs/ente-export.hcl.tmpl")
}

resource "nomad_job" "paperless" {
  jobspec = templatefile(
    "${path.module}/jobs/paperless.hcl.tmpl", {
      version  = "latest",
      hostname = var.paperless_host
  })
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
      token     = nomad_acl_token.traefik_token.secret_id,
      ca        = file("${path.module}/../local/rootCA.crt"),
      acme_dir  = var.traefik_acme_dir
      acme_main = var.traefik_acme_main
      acme_sans = var.traefik_acme_sans
  })
}