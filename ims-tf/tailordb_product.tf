resource "tailor_tailordb_type" "product" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Product"
  description  = "Product data schema"

  settings = {
    draft = true
  }

  fields = {
    title = {
      type        = "string"
      description = "Title of the product"
      index       = true
      required    = true
    }
    description = {
      type        = "string"
      description = "Description of the product"
    }
  }

  type_permission = local.permission_everyone
}
