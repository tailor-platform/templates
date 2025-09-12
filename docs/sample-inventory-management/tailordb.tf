resource "tailor_tailordb" "ims" {
  workspace_id = var.workspace_id
  namespace    = "ims"
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
        attributes = [
          "everyone",
          tailor_auth_machine_user.admin_machine_user.attributes[0],
        ]
        permit = "allow"
      }
    ]
  }
}
