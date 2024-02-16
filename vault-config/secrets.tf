# Enable Boundary related kv engine
# resource "vault_mount" "kv-boundary" {
#   path          = "boundary"
#   type          = "kv-v2"
#   options     = { version = "2" }
#   description = "Boundary related kv v2"
# }

# resource "vault_kv_secret_v2" "boundary-secret" {
#   mount                      = vault_mount.kv-boundary.path
#   name                       = "ec2London"
#   cas                        = 1
#   delete_all_versions        = true
#   data_json                  = jsonencode(
#   {
#     username = "ubuntu",
#     private_key = "${var.private_key}"
#   }
#   )
# }

# resource "vault_mount" "ssh-client-signer" {
#     path = "ssh-client-signer"
#     type = "ssh"
# }

# resource "vault_ssh_secret_backend_role" "boundary-client" {
#     name                    = "boundary-client"
#     algorithm_signer        = "rsa-sha2-512"
#     backend                 = vault_mount.ssh-client-signer.path
#     key_type                = "ca"
#     allow_user_certificates = true
#     default_user            = "ubuntu"
#     allowed_users           = "*"
#     default_extensions      = {
#       "permit-pty": ""
#     }
#     allowed_extensions      = "*"
# }

# resource "vault_ssh_secret_backend_ca" "boundary_ca" {
#     backend = vault_mount.ssh-client-signer.path
#     generate_signing_key = true
# }

# data "vault_generic_secret" "boundary_ca_public_key" {
#   path = "ssh-client-signer/config/ca"
#   depends_on = [ vault_ssh_secret_backend_ca.boundary_ca ]
# }

# resource "vault_mount" "aws-rds-db-engine" {
#     path = "aws-rds"
#     type = "database"
# }

# resource "vault_database_secret_backend_connection" "postgres" {
#   backend       = vault_mount.aws-rds-db-engine.path
#   name          = "aws-postgres"
#   allowed_roles = ["readonly"]

#   postgresql {
#     connection_url = "postgres://${data.terraform_remote_state.aws_resources.outputs.db_user}:${data.terraform_remote_state.aws_resources.outputs.db_pwd}@${data.terraform_remote_state.aws_resources.outputs.db_host}:5432/${data.terraform_remote_state.aws_resources.outputs.db_name}"
#   }
# }

# resource "vault_database_secret_backend_role" "role" {
#   backend             = vault_mount.aws-rds-db-engine.path
#   name                = "readonly"
#   db_name             = vault_database_secret_backend_connection.postgres.name
#   creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
# }