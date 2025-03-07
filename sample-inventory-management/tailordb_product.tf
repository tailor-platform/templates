resource "tailor_tailordb_type" "product" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "Product"
  description  = "Product data schema"

  settings = {
    draft = true
    publish_record_events = true
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
    shopifyID = {
			type        = "string"
			description = "Shopify product ID"
		}
		handle = {
			type        = "string"
			description = "Product handle"
		}
    featuredImageID = {
			type        = "uuid"
			description = "Featured image ID"
      foreign_key = {
        type  = "ProductImage"
        field = "id"
      }
		}
		featuredImage = {
			type        = "ProductImage"
			description = "Featured image of the product"
			source   = "featuredImageID"
		}
    inStock = {
      type        = "integer"
      description = "Quantity of the product"
      validate      = [
      // reportNumber value must be less than 100 or over 103
      {
        script        = "((value, data) => { return value >=100 && value <=103})(_value, _data)"
        action        = "deny"
        error_message = "inStock value must be less than 100 or over 103"
      }
      ]
    }
    categoryID = {
      type        = "uuid"
      description = "Category of the product"
    }
  }

  type_permission = local.permission_everyone
}
