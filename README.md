![inspec-test](https://github.com/devops-adeel/terraform-vault-auth-github/actions/workflows/terraform-apply.yml/badge.svg)

## Terraform Vault Auth Github

This terraform module onboards a GitHub team onto Vault.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Usage:

```hcl

module "vault_github_team" {
  source            = "git::https://github.com/devops-adeel/terraform-vault-auth-github.git?ref=v0.1.0"
  github_team       = "team-is"
  env               = "dev"
  service           = "web"
  policies          = ["admin", "default"]
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_identity_group.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group_alias.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_alias) | resource |
| [vault_identity_group_policies.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_policies) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The name of the environment. | `string` | `"dev"` | no |
| <a name="input_github_team"></a> [github\_team](#input\_github\_team) | The slug name of the Github team. | `string` | n/a | yes |
| <a name="input_mount_accessor"></a> [mount\_accessor](#input\_mount\_accessor) | The Accessor ID of the Approle Auth Backend. | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | List of ACL policies to bind to group | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_service"></a> [service](#input\_service) | The name of the micro-service the application is running | `string` | `"web"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
