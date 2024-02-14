#------------------------------------------------------------
# Enable userpass auth method in the 'admin' namespace
#------------------------------------------------------------
resource "vault_auth_backend" "admin-userpass" {
  type        = "userpass"
}

#-----------------------------------------------------------
# Create a user named 'admin' with password, 'changeme'
#-----------------------------------------------------------
resource "vault_generic_endpoint" "admin" {
  depends_on            = [vault_auth_backend.admin-userpass]
  path                  = "auth/userpass/users/admin"
  ignore_absent_fields  = true

  data_json = <<EOT
{
  "policies": ["admins"],
  "password": "changeme"
}
EOT
}

resource "vault_token" "boundary-token" {
  no_parent = true
  no_default_policy = true
  policies = ["boundary-policy", "boundary-read", "admins"]

  renewable = true
  period = "120m"

  metadata = {
    "purpose" = "Boundary-cred-store"
  }
}