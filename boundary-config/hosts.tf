resource "boundary_host_static" "first" {
  name            = "ec2_first"
  description     = "First EC2 host"
  address         = data.terraform_remote_state.aws_resources.outputs.ec2_first_addr
  host_catalog_id = boundary_host_catalog_static.ec2-catalog.id
}

resource "boundary_host_static" "second" {
  name            = "ec2_second"
  description     = "Second EC2 host"
  address         = data.terraform_remote_state.aws_resources.outputs.ec2_second_addr
  host_catalog_id = boundary_host_catalog_static.ec2-catalog.id
}

resource "boundary_host_static" "rds_host" {
  name = "rds"
  description = "AWS RDS Postgres Host"
  address = data.terraform_remote_state.aws_resources.outputs.db_host
  host_catalog_id = boundary_host_catalog_static.rds-catalog.id
}