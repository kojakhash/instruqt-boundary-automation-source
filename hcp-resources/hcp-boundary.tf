resource "hcp_boundary_cluster" "boundary-cluster" {
  tier       = "STANDARD"
  cluster_id = "test-hcp-boundary"
  username   = var.boundary_admin
  password   = var.boundary_admin_pass
  maintenance_window_config {
    day          = "SUNDAY"
    start        = 0
    end          = 10
    upgrade_type = "SCHEDULED"
  }
}