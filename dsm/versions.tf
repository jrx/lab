terraform {
  required_providers {
    synology = {
      source = "synology-community/synology"
    }
  }
}

provider "synology" {
  host            = var.synology_host
  user            = var.synology_user
  password        = var.synology_password
  skip_cert_check = true
}