variable "synology_host" {
  type    = string
  default = "http://synology.local:5001"
}

variable "synology_user" {
  type    = string
  default = "tf-user"
}

variable "synology_password" {
  type      = string
  default   = "testing-password"
  sensitive = true
}