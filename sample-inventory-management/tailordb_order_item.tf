resource "tailor_tailordb_type" "order_item" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_tailordb.ims.namespace
  name         = "OrderItem"
  description  = "Tracks products in each order."

  fields = {
    orderId = {
      type        = "uuid"
      description = "Unique identifier of the associated order"
      required    = true
      foreign_key = {
        type  = "Order"
        field = "id"
      }
    }
    order = {
      type     = "Order"
      description = "Link to the Orders"
      source   = "orderId"
    }
    productId = {
      type        = "uuid"
      description = "Unique identifier of the associated product"
      required    = true
      foreign_key = {
        type  = "Product"
        field = "id"
      }
    }
    product = {
      type     = "Product"
      description = "Link to the Orders"
      source   = "productId"
    }
    quantity = {
      type     = "integer"
      description = "quantity"
    }
    unitPrice = {
      type     = "float"
      description = "unit price"
    }
  }

  type_permission = local.permission_everyone
}