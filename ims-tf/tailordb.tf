resource "tailor_tailordb" "ims" {
  workspace_id = tailor_workspace.ims.id
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
          tailor_auth_machine_user.r2d2.attributes[0],
        ]
        permit = "allow"
      }
    ]
  }
}