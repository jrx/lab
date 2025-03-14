# root CA

resource "vault_mount" "pki" {
  path                      = "pki"
  type                      = "pki"
  description               = "PKI engine for the root CA"
  default_lease_ttl_seconds = 157680000 # 5 years
  max_lease_ttl_seconds     = 157680000
}

# resource "vault_pki_secret_backend_root_cert" "root" {
#   depends_on           = [vault_mount.pki]
#   backend              = vault_mount.pki.path
#   type                 = "internal"
#   common_name          = "ca.luene.org"
#   ttl                  = 157680000
#   format               = "pem"
#   private_key_format   = "der"
#   key_type             = "ec"
#   key_bits             = 256
#   max_path_length      = "-1"
#   issuer_name          = "root"
# }

resource "vault_pki_secret_backend_config_ca" "root" {
  depends_on = [vault_mount.pki]
  backend    = vault_mount.pki.path

  pem_bundle = file("${path.module}/../local/rootCA.pem")
}

resource "vault_pki_secret_backend_config_cluster" "root" {
  backend  = vault_mount.pki.path
  path     = "https://${var.vault_ip}:8200/v1/pki"
  aia_path = "https://${var.vault_ip}:8200/v1/pki"
}

resource "vault_pki_secret_backend_config_urls" "root" {
  backend = vault_mount.pki.path
  issuing_certificates = [
    "{{cluster_aia_path}}/issuer/{{issuer_id}}/der",
  ]
  crl_distribution_points = [
    "{{cluster_aia_path}}/issuer/{{issuer_id}}/crl/der",
  ]
  ocsp_servers = [
    "{{cluster_path}}/ocsp",
  ]
  enable_templating = true
}

# intermediate CA

resource "vault_mount" "pki_int" {
  path                      = "pki_int"
  type                      = vault_mount.pki.type
  description               = "PKI engine for the intermediate CA"
  default_lease_ttl_seconds = 78840000 # 2.5 years
  max_lease_ttl_seconds     = 78840000
  passthrough_request_headers = [
    "If-Modified-Since"
  ]
  allowed_response_headers = [
    "Last-Modified",
    "Location",
    "Replay-Nonce",
    "Link"
  ]
}

resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate" {
  backend     = vault_mount.pki_int.path
  type        = "internal"
  common_name = var.vault_intermediate_cn
}

resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
  backend              = vault_mount.pki.path
  csr                  = vault_pki_secret_backend_intermediate_cert_request.intermediate.csr
  common_name          = var.vault_intermediate_cn
  exclude_cn_from_sans = true
  revoke               = true
  max_path_length      = "0"
  ttl                  = 78840000
}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend     = vault_mount.pki_int.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
}

resource "vault_pki_secret_backend_config_cluster" "intermediate" {
  backend  = vault_mount.pki_int.path
  path     = "https://${var.vault_ip}:8200/v1/pki_int"
  aia_path = "https://${var.vault_ip}:8200/v1/pki_int"
}

resource "vault_pki_secret_backend_config_urls" "intermediate" {
  backend = vault_mount.pki_int.path
  issuing_certificates = [
    "{{cluster_aia_path}}/issuer/{{issuer_id}}/der",
  ]
  crl_distribution_points = [
    "{{cluster_aia_path}}/issuer/{{issuer_id}}/crl/der",
  ]
  ocsp_servers = [
    "{{cluster_path}}/ocsp",
  ]
  enable_templating = true
}

# ACME role

resource "vault_pki_secret_backend_role" "test" {
  backend          = vault_mount.pki_int.path
  name             = "vm01"
  allowed_domains  = ["test.lan"]
  allow_subdomains = true
  key_type         = "any"
  max_ttl          = 2592000
}

resource "vault_pki_secret_backend_config_acme" "intermediate" {
  backend                  = vault_mount.pki_int.path
  enabled                  = true
  allowed_issuers          = ["*"]
  allowed_roles            = [vault_pki_secret_backend_role.test.name]
  allow_role_ext_key_usage = false
  default_directory_policy = "sign-verbatim"
  dns_resolver             = ""
  eab_policy               = "not-required"
}


