resource "tailor_tailordb_type" "role" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.prj_mgmt.namespace
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
}