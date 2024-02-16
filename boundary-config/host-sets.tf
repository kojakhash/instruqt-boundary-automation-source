# resource "boundary_host_set_static" "aws-ec2" {
#   host_catalog_id = boundary_host_catalog_static.ec2-catalog.id
#   host_ids = [
#     boundary_host_static.first.id,
#     boundary_host_static.second.id,
#   ]
# }

# resource "boundary_host_set_static" "aws-rds" {
#   host_catalog_id = boundary_host_catalog_static.rds-catalog.id
#   host_ids = [
#     boundary_host_static.rds_host.id
#   ]
# }