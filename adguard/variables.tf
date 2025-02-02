variable "adguard_host" {
  type    = string
  default = "http://adguard.local:3000"
}

variable "adguard_username" {
  type    = string
  default = "adguard"
}

variable "adguard_password" {
  type      = string
  default   = "testing-password"
  sensitive = true
}