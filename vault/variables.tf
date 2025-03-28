variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
}

variable "vault_intermediate_cn" {
  type    = string
  default = "test.ca.example.com"
}

variable "vault_ip" {
  type    = string
  default = "172.0.0.1"
}

variable "nomad_ip" {
  type    = string
  default = "172.0.0.1"
}