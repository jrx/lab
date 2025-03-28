terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
  }
  backend "local" {}
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}