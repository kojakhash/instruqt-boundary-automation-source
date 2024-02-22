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