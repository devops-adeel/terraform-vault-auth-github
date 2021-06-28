locals {
  application = "terraform-vault-auth-github"
  env         = "dev"
  service     = "adeel"
}

resource "vault_github_auth_backend" "default" {
  organization = local.application
}

module "default" {
  source         = "./module"
  github_team    = local.application
  env            = "dev"
  service        = "web"
  mount_accessor = vault_github_auth_backend.default.accessor
  policies       = ["default"]
}
