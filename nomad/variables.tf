variable "nomad_address" {
  type    = string
  default = "http://127.0.0.1:4646"
}

variable "nomad_secret_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "traefik_acme_dir" {
  type    = string
  default = "https://127.0.0.1:8200/v1/pki_int/acme/directory"
}

# variable "vault_cn" {
#   type    = string
#   default = "vault.example.com"
# }

# variable "vault_dns_names" {
#   type = list(any)
#   default = [
#     "vault.example.com",
#     "vault",
#     "localhost",
#   ]
# }

# variable "vault_ip_addresses" {
#   type = list(any)
#   default = [
#     "127.0.0.1",
#   ]
# }

variable "adguard_host" {
  type    = string
  default = "adguard.example.com"
}

variable "paperless_host" {
  type    = string
  default = "paperless.example.com"
}

variable "cyberchef_host" {
  type    = string
  default = "cyberchef.example.com"
}

variable "karakeep_host" {
  type    = string
  default = "karakeep.example.com"
}

variable "traefik_acme_main" {
  type    = string
  default = "example.com"
}

variable "traefik_acme_sans" {
  type    = string
  default = "[\"test.example.com\"]"
}