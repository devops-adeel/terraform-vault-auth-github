output "url" {
  value = data.terraform_remote_state.default.outputs.vault_public_endpoint_url
}

output "namespace" {
  value = format("admin/%s/", local.application)
}

output "org" {
  description = "Github Organisation"
  value       = local.application
}
