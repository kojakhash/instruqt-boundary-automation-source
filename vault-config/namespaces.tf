# #--------------------------------------
# # Create 'admin/staging' namespace
# #--------------------------------------
# resource "vault_namespace" "staging" {
#   path = "Staging"
# }

# #---------------------------------------------------
# # Create 'admin/staging/project1' namespace
# #---------------------------------------------------
# resource "vault_namespace" "project1" {
#   depends_on    = [vault_namespace.staging]
#   namespace     = vault_namespace.staging.path
#   path          = "Project1"
# }
