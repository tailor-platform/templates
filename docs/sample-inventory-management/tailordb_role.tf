resource "tailor_tailordb_type" "role" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Role"
  description  = "User roles."

  fields = {
    name = {
      type        = "string"
      description = "Name of the Role."
      index       = true
      required    = true
	}
  }

  type_permission = local.permission_everyone
}