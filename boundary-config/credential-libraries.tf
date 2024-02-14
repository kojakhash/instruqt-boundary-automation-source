resource "boundary_credential_library_vault" "dynamic_rds" {
  name                = "RDS dynamic creds"
  description         = "Dynamic credentials provided by Database Secret Engine"
  credential_store_id = boundary_credential_store_vault.hcp-vault.id
  path                = "aws-rds/creds/readonly" # change to Vault backend path
  credential_type     = "username_password"
  http_method         = "GET"
}

resource "boundary_credential_library_vault_ssh_certificate" "vault_ssh_cert" {
  name = "certificates-library"
  description = "Dynamic SSh Certificates"
  path = "ssh-client-signer/sign/boundary-client"
  credential_store_id = boundary_credential_store_vault.hcp-vault.id
  username = "ubuntu"
  key_type = "rsa"
  key_bits = 2048
  extensions = {
   "permit-pty": ""
  }
}