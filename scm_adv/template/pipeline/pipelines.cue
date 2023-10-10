package pipelines

import (
	"tailor.build/scm-adv/charts/directory:directories"
	"tailor.build/scm-adv/charts/pipeline/resolvers"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
)

pipeline: pipelinev1.#Manifests & {
	namespace:   {{ .Values.pipeline.namespace | quote }}
	invoker:     directories.roleMap.Admin.id
	description: "SCM pipeline resolver"
	sdl: """
  input cancelOrderInput {
    orderID: ID!
  }
  input changeToDELIVEREDInput {
    deliveryID: ID!
    deliveryDate: Date!
  }
  input changeToINTRANSITInput {
    deliveryID: ID!
    deliveryDate: Date!
  }
  input editOrderInput {
    orderID: ID!
    quantity: Int!
    productID: ID!
    locationID: ID!
  }
  input editPurchaseInput {
    orderID: ID!
    quantity: Int!
    productID: ID!
    locationID: ID!
  }
  input placeOrderInput {
    quantity: Int!
    productID: ID!
    locationID: ID!
    placedDate: Date!
  }
  input placePurchaseInput {
    quantity: Int!
    productID: ID!
    locationID: ID!
    placedDate: Date!
  }
  input transferInventoryInput {
    quantity: Int!
    deliveryDate: Date!
    productID: ID!
    transferOutID: ID!
    transferInID: ID!
  }
  type cancelOrderResult {
    id: ID
  }
  type changeToDELIVEREDResult {
    deliveryID: ID
    inventoryEventID: ID
    revertInventoryEventID: ID
  }
  type changeToINTRANSITResult {
    deliveryID: ID
    inventoryEventID: ID
    revertInventoryEventID: ID
  }
  type editOrderResult {
    orderID: ID
    deliveryID: ID
    inventoryEventID: ID
  }
  type editPurchaseResult {
    orderID: ID
    deliveryID: ID
    inventoryEventID: ID
  }
  type placeOrderResult {
    id: ID
  }
  type placePurchaseResult {
    id: ID
  }
  type transferInventoryResult {
    transferInID: ID
    transferOutID: ID
  }
  type Mutation {
    cancelOrder(input: cancelOrderInput): cancelOrderResult
    changeToDELIVERED(input: changeToDELIVEREDInput): changeToDELIVEREDResult
    changeToINTRANSIT(input: changeToINTRANSITInput): changeToINTRANSITResult
    editOrder(input: editOrderInput): editOrderResult
    editPurchase(input: editPurchaseInput): editPurchaseResult
    placeOrder(input: placeOrderInput): placeOrderResult
    placePurchase(input: placePurchaseInput): placePurchaseResult
    transferInventory(input: transferInventoryInput): transferInventoryResult
  }
  """
	resolverMap: {
		"cancelOrder":       resolvers.cancelOrder
		"changeToDELIVERED": resolvers.changeToDELIVERED
		"changeToINTRANSIT": resolvers.changeToINTRANSIT
		"editOrder":         resolvers.editOrder
		"editPurchase":      resolvers.editPurchase
		"placeOrder":        resolvers.placeOrder
		"placePurchase":     resolvers.placePurchase
		"transferInventory": resolvers.transferInventory
	}
}
