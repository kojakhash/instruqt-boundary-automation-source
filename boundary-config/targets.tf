# resource "boundary_target" "ec2" {
#   name         = "EC2 Targets"
#   description  = "SSH To EC2s Target"
#   type         = "ssh"
#   default_port = "22"
#   scope_id     = boundary_scope.devops_project.id
#   host_source_ids = [
#     boundary_host_set_static.aws-ec2.id
#   ]
#   injected_application_credential_source_ids = [
#     boundary_credential_library_vault_ssh_certificate.vault_ssh_cert.id
#   ]
# }

# resource "boundary_target" "rds" {
#   name = "RDS Target"
#   description = "RDS Target"
#   type = "tcp"
#   default_port = "5432"
#   scope_id = boundary_scope.devops_project.id
#   host_source_ids = [
#     boundary_host_set_static.aws-rds.id
#   ]
#   brokered_credential_source_ids = [
#     boundary_credential_library_vault.dynamic_rds.id
#   ]
# }