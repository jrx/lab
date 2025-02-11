variable "nomad_address" {
  type    = string
  default = "http://127.0.0.1:4646"
}

variable "nomad_secret_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "vault_shared_san" {
  type        = string
  description = "This is a shared server name that the certs for all Vault nodes contain. This is the same value you will supply as input to the Vault installation module for the leader_tls_servername variable."
  default     = "vault"
}