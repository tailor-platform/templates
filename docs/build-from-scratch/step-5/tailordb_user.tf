resource "tailor_tailordb_type" "user" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt.namespace
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
}
