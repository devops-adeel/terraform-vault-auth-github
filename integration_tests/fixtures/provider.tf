terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  backend "remote" {
    organization = "hc-implementation-services"

    workspaces {
      name = "terraform-vault-auth-github"
    }
  }
}

data "terraform_remote_state" "default" {
  backend = "remote"

  config = {
    organization = "hc-implementation-services"

    workspaces = {
      name = "terraform-hcp-vault"
    }
  }
}

variable "approle_id" {}
variable "approle_secret" {}

provider "github" {
  owner = "terraform-vault-auth-github"
}

provider "vault" {
  auth_login {
    namespace = "admin/terraform-vault-auth-github"
    path      = "auth/approle/login"

    parameters = {
      role_id   = var.approle_id
      secret_id = var.approle_secret
    }
  }
}
