resource "tailor_tailordb" "prj_mgmt" {
  workspace_id = var.workspace_id
  namespace    = "prj-mgmt"
}

locals {
  permission_admin = {
    left     = { user = "role" }
    operator = "eq"
    right    = { value = { string = "ADMIN" } }
  }
}