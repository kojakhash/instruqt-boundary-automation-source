////////////////////////////////// HVN VARIABLES //////////////////////////////////
variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
}

variable "hcp_cluster_id" {
  description = "The ID of the HCP Vault/Consul cluster."
  type        = string
}

# variable "peering_id" {
#   description = "The ID of the HCP peering connection."
#   type        = string
#   default     = "learn-peering"
# }

# variable "route_id" {
#   description = "The ID of the HCP HVN route."
#   type        = string
#   default     = "learn-hvn-route"
# }

variable "hvn_region" {
  description = "The region of the HCP HVN and Vault cluster."
  type        = string
}

variable "hvn_cloud_provider" {
  description = "The cloud provider of the HCP HVN and Vault cluster."
  type        = string
  default     = "aws"
}

variable "hvn_cidr_block"{
  type        = string
  default     = "172.16.16.0/20"
}

////////////////////////////////// VAULT VARIABLES //////////////////////////////////
variable "tier" {
  description = "Tier of the HCP Vault cluster. Valid options for tiers."
  type        = string
  default     = "dev"
}

////////////////////////////////// BOUNDARY VARIABLES //////////////////////////////////
variable "boundary_admin" {
  type        = string
}

variable "boundary_admin_pass" {
  type        = string
  sensitive   = true
}