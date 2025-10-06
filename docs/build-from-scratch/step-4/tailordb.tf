resource "tailor_tailordb" "project_management" {
  workspace_id = var.workspace_id
  namespace    = "prj_mgmt"
}

locals {
  permission_admin = {
    left     = { user = "role" }
    operator = "eq"
    right    = { value = { string = "ADMIN" } }
  }
}