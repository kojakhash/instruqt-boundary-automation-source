resource "boundary_host_catalog_static" "ec2-catalog" {
  name        = "AWS EC2"
  description = "Host Catalog for EC2"
  scope_id    = boundary_scope.devops_project.id
}

resource "boundary_host_catalog_static" "rds-catalog" {
  name        = "AWS RDS"
  description = "Host Catalog for RDS"
  scope_id    = boundary_scope.devops_project.id
}