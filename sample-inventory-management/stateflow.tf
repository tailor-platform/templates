resource "tailor_stateflow" "ims" {
  workspace_id = tailor_workspace.ims.id
  namespace    = "ims"

  admins = [
    tailor_auth_machine_user.r2d2.attributes[0],
  ]
}