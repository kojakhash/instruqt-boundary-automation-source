# resource "boundary_credential_store_vault" "hcp-vault" {
#   name        = "HCP Vault"
#   description = "HCP Vault Credential Store"
#   address     = data.terraform_remote_state.hcp_resources.outputs.hcp_vault_public_addr
#   token       = data.terraform_remote_state.hcp_vault_manage.outputs.boundary_token
#   scope_id    = boundary_scope.devops_project.id
#   namespace   = "admin"
# }