# output "boundary_token" {
#   value = vault_token.boundary-token.client_token
#   sensitive = true
# }

# output "vault_boundary_ssh_ca" {
#   value = chomp(data.vault_generic_secret.boundary_ca_public_key.data["public_key"])
#   sensitive = true
# }