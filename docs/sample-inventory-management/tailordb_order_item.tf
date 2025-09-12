resource "tailor_tailordb_type" "order_item" {
  workspace_id = var.workspace_id
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
    price = {
      type     = "float"
      description = "unit price"
    }
    totalPrice = {
      type        = "integer"
      description = "Total price of a certain product"
      hooks = {
        create = "_data.price * _data.quantity"
        update = "_data.price * _data.quantity"
      }
      validate = [
        {
          expr   = "_value < 100"
          action = "deny"
        },
        {
          expr   = "_value.price < 10"
          action = "deny"
        },
      ]
    }
  }
  type_permission = local.permission_everyone
}
