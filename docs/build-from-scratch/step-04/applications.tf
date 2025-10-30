resource "tailor_application" "project_management" {
  workspace_id = var.workspace_id

  auth = {
    namespace = tailor_auth.prj_mgmt_auth.namespace
  }

  name = "project-management"
  cors = [
    "http://localhost:8080",
    "http://localhost:8081",
  ]
  allowed_ip_addresses = [
    "0.0.0.0/0",
  ]
  subgraphs = [
    {
      type      = "tailordb"
      namespace = tailor_tailordb.prj_mgmt_db.namespace
    },
    {
      type      = "auth"
      namespace = tailor_auth.prj_mgmt_auth.namespace
    }
  ]
}
