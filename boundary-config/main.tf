terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.82.0"
    }
  }
}

data "terraform_remote_state" "hcp_resources" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "hcp-resources"
    }
  }
}

data "terraform_remote_state" "hcp_vault_manage" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "hcp-vault-manage"
    }
  }
}

data "terraform_remote_state" "aws_resources" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "aws-resources"
    }
  }
}

provider "hcp" {}

provider "vault" {
  token = data.terraform_remote_state.hcp_resources.outputs.admin_token
  address = data.terraform_remote_state.hcp_resources.outputs.hcp_vault_public_addr
}

provider "boundary" {
  addr                            = data.terraform_remote_state.hcp_resources.outputs.boundary_url
  auth_method_login_name          = data.terraform_remote_state.hcp_resources.outputs.boundary_username
  auth_method_password            = data.terraform_remote_state.hcp_resources.outputs.boundary_pasword
}
