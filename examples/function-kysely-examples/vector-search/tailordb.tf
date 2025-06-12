resource "tailor_tailordb_type" "product" {
  workspace_id = tailor_workspace.demo.id
  namespace    = tailor_tailordb.demo.namespace
  name         = "Product"

  fields = {
    name = {
      type     = "string"
      required = true
      index    = true
      unique   = true
    }
    description = {
      type     = "string"
      required = true
      vector   = true
    }
  }

  type_permission = local.tailordb_permission_everyone
}
