terraform {
  required_providers {
    adguard = {
      source = "gmichels/adguard"
    }
  }
  backend "local" {}
}

provider "adguard" {
  host     = var.adguard_host
  username = var.adguard_username
  password = var.adguard_password
  scheme   = "https"
  insecure = true
}