resource "tailor_tailordb_type" "user" {
  workspace_id = tailor_workspace.demo.id
  namespace    = tailor_tailordb.demo.namespace
  name         = "User"

  fields = {
    name = {
      type = "string"
    }
    createdAt = {
      type     = "datetime"
      required = true
      hooks = {
        create = "(new Date()).toISOString()"
      }
    }
  }

  type_permission = local.tailordb_permission_everyone
}
