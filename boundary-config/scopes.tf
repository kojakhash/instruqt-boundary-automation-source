resource "boundary_scope" "global" {
  global_scope = true
  scope_id     = "global"
}

resource "boundary_scope" "devops" {
  name                     = "DevOps"
  description              = "DevOps organisation for access management"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "devops_project" {
  name                   = "DevOps_Projects"
  description            = "Backend Project"
  scope_id               = boundary_scope.devops.id
  auto_create_admin_role = true
}