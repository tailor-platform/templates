package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

// Here add the table name and its plural form
#tables: {
	StockSummary:          "stockSummaries"
	FinancialStockSummary: "financialStockSummaries"
	FinancialStockEvent:   "financialStockEvents"
	OperationalStockEvent: "operationalStockEvents"
	ShipmentLineItem:      "shipmentLineItems"
	SalesOrderLineItem:    "salesOrderLineItems"
	PurchaseOrderLineItem: "purchaseOrderLineItems"
	ReceiptLineItem:       "receiptLineItems"
	CostPoolLineItem:      "costPoolLineItems"
	InventoryLevel:        "inventoryLevels"
	InventoryItem:         "inventoryItems"
	InvoiceLineItem:       "invoiceLineItems"
	CostPool:              "costPools"
	Invoice:               "invoices"
	PurchaseOrder:         "purchaseOrders"
	Receipt:               "receipts"
	SalesOrder:            "salesOrders"
	Shipment:              "shipments"
	Location:              "locations"
	ProductImage:          "productImages"
	ProductVariant:        "productVariants"
	Product:               "products"
	Contact:               "contacts"
	Role:                  "roles"
	User:                  "users"
}

deleteAllTailorDBRecords: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "deleteAllTailorDBRecords"
	Description: """
		DANGER: Delete all the records in the database. This is a resolver for development purpose only.
		"""
	Response: {Type: pipeline.String}
	PostScript: "'RECORDS DELETED'"
	Pipelines: [
		for table, plural in #tables {
			{
				Name:        "get\(table)"
				Description: "Get all the \(table) records."
				Invoker:     settings.adminInvoker
				Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
					Query: """
                    query {
                        \(plural)(first: 1000){
                            edges{
								node {
                                	id
								}
                            }
                        }
                    }"""
				}
				PostScript: """
                {
                    "items": args.\(plural).edges.map(edge, edge.node)
                }"""
			}
		},
		for table, plural in #tables {
			{
				Name:        "delete\(table)"
				Description: "Delete the \(table) records"
				Invoker:     settings.adminInvoker
				ForEach:     "context.pipeline.get\(table).items"
				Test:        "size(context.pipeline.get\(table).items) > 0" // skip if no records are found
				PreScript: """
					{
					    "id": each.id,
					}
					"""
				Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
					Query: """
                    mutation delete\(table)($id: ID!) {
                        delete\(table)(id: $id)
                    }"""
				}
				PostScript: """
                {
                    "result": args.delete\(table)
                }"""
			}
		},
	]
}
