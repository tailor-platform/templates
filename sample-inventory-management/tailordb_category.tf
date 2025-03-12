resource "tailor_tailordb_type" "category" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Category"
  description  = "Contains information about categories of products."

  settings = {
    bulk_upsert = true
    publish_record_events = true
  }

  fields = {
    name = {
      type        = "string"
      description = "Name of the category."
	  }
    description = {
      type        = "string"
      description = "Description of the category."
	  }
    createdAt = {
      type        = "datetime"
      description = "Creation date of the category"
      hooks = {
        create = "(new Date()).toISOString()"
      }
    }
  }

  type_permission = local.permission_everyone
}