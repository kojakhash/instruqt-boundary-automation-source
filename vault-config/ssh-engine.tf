resource "vault_mount" "ssh-client-signer" {
    path = "ssh-client-signer"
    type = "ssh"
}

resource "vault_ssh_secret_backend_role" "boundary-client" {
    name                    = "boundary-client"
    algorithm_signer        = "rsa-sha2-512"
    backend                 = vault_mount.ssh-client-signer.path
    key_type                = "ca"
    allow_user_certificates = true
    default_user            = "ubuntu"
    allowed_users           = "*"
    default_extensions      = {
      "permit-pty": ""
    }
    allowed_extensions      = "*"
}

resource "vault_ssh_secret_backend_ca" "boundary_ca" {
    backend = vault_mount.ssh-client-signer.path
    generate_signing_key = true
}

data "vault_generic_secret" "boundary_ca_public_key" {
  path = "ssh-client-signer/config/ca"
  depends_on = [ vault_ssh_secret_backend_ca.boundary_ca ]
}