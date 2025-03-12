resource "tailor_tailordb_type" "product_image" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "ProductImage"
  description  = "Product Image"

  settings = {
    bulk_upsert = true
  }

  fields = {
    shopifyID = {
      type        = "string"
      description = "Shopify image ID"
	}
    url = {
      type        = "string"
      description = "Image URL"
	}
    altText = {
      type        = "string"
      description = "Alt text"
	}
  }

  type_permission = local.permission_everyone
}