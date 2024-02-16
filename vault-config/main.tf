terraform {
  required_providers {
    vault = "~> 3.19.0"
  }
}

data "terraform_remote_state" "hcp_vault" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "hcp-resources"
    }
  }
}

# data "terraform_remote_state" "aws_resources" {
#   backend = "remote"

#   config = {
#     organization = var.tfc_org
#     workspaces = {
#       name = "aws-resources"
#     }
#   }
# }


provider "vault" {
  token = data.terraform_remote_state.hcp_vault.outputs.admin_token
  address = data.terraform_remote_state.hcp_vault.outputs.hcp_vault_public_addr
  namespace = "admin"
}