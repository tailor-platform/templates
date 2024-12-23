package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

createInvoiceFromShipment: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createInvoiceFromShipment"
	Description: """
		This pipeline creates a new invoice from a shipment. The steps are:
		Steps:  
		1. Fetch the shipment and its line items
		2. Create a invoice and get the ID
		3. bulk create the invoice line items
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "createInvoiceFromShipmentInput"
				Fields: [
					{Name: "shipmentID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: pipeline.String}
	PostScript: "context.pipeline.createInvoice.id"
	Pipelines: [
		{
			Name:        "fetchShipment"
			Description: "Fetch the shipment and its line items"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					                query  ( $shipmentID: ID!) {
					                    shipment(id: $shipmentID) {
					                        id
					                        customerID
					                    }
					                    shipmentLineItems(query: {shipmentID: {eq: $shipmentID}}) {
					                        collection {
					                            id
					                            variantID
					                            quantity
					                            unitPrice
					                            taxable
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "shipment": args.shipment,
				                "shipmentLineItems": args.shipmentLineItems.collection
				            }"""
			PostValidation: """
				isNull(context.pipeline.fetchShipment.shipment) ? 
				"Shipment not found" : 
				""
				"""
		},
		{
			Name:        "createInvoice"
			Description: "Create a new invoice from the shipment"
			Invoker:     settings.adminInvoker
			PreScript: """
				{
				    "input": {
				        "shipmentID": context.pipeline.fetchShipment.shipment.id,
				        "customerID": context.pipeline.fetchShipment.shipment.customerID,
				    }
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($input: InvoiceCreateInput!) {
					    createInvoice(input: $input) {
					        id
					    }
					}
					"""
			}
			PostScript: "args.createInvoice"
		},
		{
			Name:        "createInvoiceLineItems"
			Description: "Create Invoice line items from the sales order line items"
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.fetchShipment.shipmentLineItems) > 0"
			PreScript: """
				{
				    "input": context.pipeline.fetchShipment.shipmentLineItems.map(item, {
				        "invoiceID": context.pipeline.createInvoice.id,
				        "variantID": item.variantID,
				        "quantity": item.quantity,
				        "taxable": item.taxable,
				        "unitPrice": item.unitPrice
				    })
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($input: [InvoiceLineItemCreateInput]) {
					    bulkUpsertInvoiceLineItems(input: $input)
					}
					"""
			}
			PostScript: "args.bulkUpsertInvoiceLineItems"
		},
	]
}
