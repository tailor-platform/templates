resource "tailor_tailordb_type" "user" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "User"
  description  = "User of the system."

  fields = {
    name = {
      type        = "string"
      description = "Name of the user."
      index       = true
      required    = true
	}
    email = {
      type        = "string"
      description = "Email of the user."
      required    = true
	}
    roles = {
      type        = "uuid"
      description = "Role IDs of the user."
      array       = true
	}
  }

  type_permission = local.permission_everyone
}