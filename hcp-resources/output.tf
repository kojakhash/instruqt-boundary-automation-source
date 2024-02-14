////////////////////////////////// HVN OUTPUTS //////////////////////////////////
output "hvn_self" {
  value = hcp_hvn.learn_hcp_vault_hvn.self_link
}

output "hvn_id" {
  value = hcp_hvn.learn_hcp_vault_hvn.hvn_id
}

output "hvn_cidr" {
  value = var.hvn_cidr_block
}


////////////////////////////////// VAULT OUTPUTS //////////////////////////////////
output "hcp_vault_private_addr" {
  value = hcp_vault_cluster.learn_hcp_vault.vault_private_endpoint_url
}

output "hcp_vault_public_addr" {
  value = hcp_vault_cluster.learn_hcp_vault.vault_public_endpoint_url
}

output "admin_token" {
  value = hcp_vault_cluster_admin_token.admin.token
  sensitive = true
}

////////////////////////////////// BOUNDARY OUTPUTS //////////////////////////////////
output "boundary_username"{
  value = var.boundary_admin
}

output "boundary_pasword" {
  value = var.boundary_admin_pass
  sensitive = true
}

output "boundary_url" {
  value = hcp_boundary_cluster.boundary-cluster.cluster_url
}
