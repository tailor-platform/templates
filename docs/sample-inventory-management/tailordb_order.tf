resource "tailor_tailordb_type" "order" {
  workspace_id = var.workspace_id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Order"
  description  = "Contains information about product orders."

  fields = {
    name = {
      type        = "string"
      description = "Name of the order."
	  }
    description = {
      type        = "string"
      description = "Description of the order."
	  }
    orderDate = {
      type        = "datetime"
      description = "Date of the order."    
    }
    orderType = {
      type        = "enum"
      description = "Order type. Either purchase or sales"
      allowed_values = [
		    {
          value       = "PURCHASE"
          description = "PURCHASE type"
		    },
		    {
          value       = "SALES"
          description = "SALES type"
		    }
	    ]
    }
    orderType = {
      type        = "enum"
      description = "Order status"
      allowed_values = [
		    {
          value       = "PENDING"
          description = "PENDING type"
		    },
		    {
          value       = "COMPLETED"
          description = "COMPLETED type"
		    },
        {
          value       = "SALES"
          description = "SALES type"
		    }
	    ]
    }
    contactId = {
      type        = "uuid"
      description = "Unique identifier of the associated contact"
      required    = true
      foreign_key = {
        type  = "Contact"
        field = "id"
      }
    }
    contact = {
      type     = "Contact"
      description = "Link to the Contacts"
      source   = "contactId"
    }
  }

  type_permission = local.permission_everyone
}
