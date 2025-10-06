resource "tailor_tailordb" "project_management" {
  workspace_id = var.workspace_id
  namespace    = "prj_mgmt"
}

locals {
  permission_everyone = {
    create = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    read = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    update = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    delete = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    admin = [
      {
        attributes = "everyone"
        permit = "allow"
      }
    ]
  }
}