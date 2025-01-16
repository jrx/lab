variable "nomad_address" {
  type    = string
  default = "http://127.0.0.1:4646"
}

variable "nomad_secret_id" {
  type      = string
  default   = ""
  sensitive = true
}