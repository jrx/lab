terraform {
  required_providers {
    nomad = {
      source = "hashicorp/nomad"
    }
  }
  backend "local" {}
}

provider "nomad" {
  address   = var.nomad_address
  secret_id = var.nomad_secret_id
}