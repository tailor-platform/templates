resource "tailor_tailordb_type" "character" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Character"
  description  = "Character data schema"
  directives = [
    {
      name = "key"
      args = [
        {
          name  = "fields"
          value = "id"
        }
      ]
    }
  ]

  settings = {
    bulk_upsert = true
    aggregation = true
  }

  fields = {
    createdAt = {
      type        = "datetime"
      description = "Creation date of the character"
      index       = true
      hooks = {
        create = "(new Date()).toISOString()"
      }
    }
    name = {
      type        = "string"
      description = "Name of the character"
      index       = true
      required    = true
    }
    email = {
      type        = "string"
      description = "Email address of the character"
      index       = true
      unique      = true
      required    = true
    }
  }
  type_permission = local.permission_everyone

}
