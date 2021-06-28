/**
 * Usage:
 *
 * ```hcl
 *
 * module "vault_github_team" {
 *   source            = "git::https://github.com/devops-adeel/terraform-vault-auth-github.git?ref=v0.1.0"
 *   github_team       = "team-is"
 *   env               = "dev"
 *   service           = "web"
 *   policies          = ["admin", "default"]
 * }
 * ```
 */


locals {
  env            = var.env
  service        = var.service
  application    = var.github_team
  policies       = var.policies
  mount_accessor = var.mount_accessor
}

resource "vault_identity_group" "default" {
  name              = local.application
  type              = "external"
  external_policies = true

  metadata = {
    env         = local.env
    service     = local.service
    application = local.application
  }
}

resource "vault_identity_group_alias" "default" {
  name           = local.application
  mount_accessor = local.mount_accessor
  canonical_id   = vault_identity_group.default.id
}

resource "vault_identity_group_policies" "default" {
  policies  = local.policies
  exclusive = false
  group_id  = vault_identity_group.default.id
}
