terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
  }
  backend "local" {}
}

provider "vault" {}