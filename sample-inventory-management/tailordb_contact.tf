resource "tailor_tailordb_type" "contact" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Contact"
  description  = "Contains information about suppliers and customers."

  fields = {
    name = {
      type        = "string"
      description = "Name of the contact."
	  }
    email = {
      type        = "string"
      description = "Email."
	  }
    phone = {
      type        = "string"
      description = "Phone number."
	  }
    address = {
      type        = "string"
      description = "Address"
	  }
    contactType = {
      type        = "enum"
      description = "Contact type. Either supplier or customer"
      allowed_values = [
		  {
        value       = "SUPPLIER"
        description = "SUPPLIER type"
		  },
		  {
        value       = "CUSTOMER"
        description = "CUSTOMER type"
		  }
	    ]
    }
  }

  type_permission = local.permission_everyone
}