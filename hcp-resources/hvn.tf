resource "hcp_hvn" "learn_hcp_vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.hvn_cloud_provider
  region         = var.hvn_region
  cidr_block     = var.hvn_cidr_block
}