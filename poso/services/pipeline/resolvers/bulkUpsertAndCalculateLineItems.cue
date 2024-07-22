package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
)

BUCLineItem: {
	Name: "BUCLineItem"
	Fields: [
		{
			Name:     "id"
			Required: false
			Type:     pipeline.ID
		},
		{
			Name:     "productID"
			Required: true
			Type:     pipeline.ID
		},
		{
			Name:     "quantity"
			Required: true
			Type:     pipeline.Int
		},
		{
			Name:     "name"
			Required: false
			Type:     pipeline.String
		},
		{
			Name:     "unitCost"
			Required: false
			Type:     pipeline.Float
		},
		{
			Name:     "unitPrice"
			Required: false
			Type:     pipeline.Float
		},
		{
			Name:     "taxID"
			Required: false
			Type:     pipeline.ID
		},
	]
}

bulkUpsertAndCalculateLineItems: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "bulkUpsertAndCalculateLineItems"
	Description: """
		The purpose of this Pipeline is to centralize the update and delete process for all lineItems. Meaning,
		the pipeline takes as input a list of lineItems for a document and then will create or update the lineItems
		including the calculations of taxes.
		This pipeline follows the following steps:
		- Get the products from the given productIDs. Throw an error if the products are not found
		- Get the taxes from the given taxIDs.Throw an error if the taxes are not found
		- Map the data to create or update the lineItems
		- Create the lineItems
		- Update the lineItems
		"""
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "bulkUpsertAndCalculateLineItemsInput"
				Fields: [
					{
						Name:     "lineItems"
						Required: true
						Array:    true
						Type:     BUCLineItem
					},
					{
						Name:     "documentID"
						Required: true
						Type:     pipeline.ID
					},
				]
			}
		},
	]
	PostScript: """
		    {
		        "result": string( 
		                (!isNull(context.pipeline.createLineItems) ? size(context.pipeline.createLineItems) : 0 ) 
		                + (!isNull(context.pipeline.updateLineItems) ? size(context.pipeline.updateLineItems) : 0 ) 
		            ) + " Records updated or created",
		        "error": ""
		    }"""
	Response: {Type: standardPipelineResult}
	Pipelines: [
		{
			Name:        "getProducts"
			Description: "Verify that the Document and LineItem records exist in the database before proceeding with the aggregation and update process."
			Invoker:     settings.adminInvoker
			PreScript: """
				            {
				                "productIDs": args.input.lineItems.map(lineItem, lineItem.productID)
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query product ($productIDs: [ID]){
					                products(query: { id: { in: $productIDs } }, size: 10000) {
					                    collection{
					                        id
					                        name
					                        unitCost
					                        unitPrice
					                        taxID
					                        tax{
					                            id
					                            taxRate
					                        }
					                    }
					                }
					                }"""
			}
			PostScript: "args.products.collection"
			PostValidation: """
				    size(context.pipeline.getProducts) == 0 ? "Products not found" :  ""
				"""
		},
		{
			Name:        "getTaxes"
			Description: "Gets the tax rates from the given taxIDs in products and lineItems."
			Invoker:     settings.adminInvoker
			PreScript: """
				            {
				                "taxIDs": context.args.input.lineItems.filter(li, has(li.taxID)).map(lineItem, lineItem.taxID)
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query tax ($taxIDs: [ID]){
					                taxes(query: { id: { in: $taxIDs } }) {
					                    collection{
					                        id
					                        taxRate
					                    }
					                }
					                }"""
			}
			PostScript: "args.taxes.collection + context.pipeline.getProducts.map(p, p.tax)"
			PostValidation: """
				    size(context.pipeline.getTaxes) == 0 ? "Taxes not found" :  ""
				"""
		},
		{
			Name:        "mappedData"
			Description: "Verify that the Document and LineItem records exist in the database before proceeding with the aggregation and update process."
			Invoker:     settings.adminInvoker
			PostScript: """
				            {
				                "toCreateLineItems": context.args.input.lineItems
				                    .filter(lineItem, isNull(lineItem.id))
				                    .map(lineItem, {
				                        "lineItem": lineItem,
				                        "product": context.pipeline.getProducts.filter(
				                            (p), p.id == lineItem.productID)[0]
				                    })
				                    .map(e, {
				                        "documentID": context.args.input.documentID,
				                        "productID": e.lineItem.productID,
				                        "quantity": e.lineItem.quantity,
				                        "name": isNull(e.lineItem.name) ? e.product.name : e.lineItem.name,
				                        "unitCost": isNull(e.lineItem.unitCost) ? e.product.unitCost : e.lineItem.unitCost,
				                        "unitPrice": isNull(e.lineItem.unitPrice) ? e.product.unitPrice : e.lineItem.unitPrice,
				                        "taxID": isNull(e.lineItem.taxID) ? e.product.taxID : e.lineItem.taxID,
				                        "taxRate": context.pipeline.getTaxes.filter(
				                                t, t.id == (
				                                    isNull(e.lineItem.taxID) ? 
				                                    e.product.taxID 
				                                    : e.lineItem.taxID
				                                    )
				                            )[0].taxRate
				                    }),
				                "toUpdateLineItems": context.args.input.lineItems
				                    .filter(lineItem, !isNull(lineItem.id))
				                    .map(lineItem, {
				                        "lineItem": lineItem,
				                        "product": context.pipeline.getProducts.filter(
				                            (p), p.id == lineItem.productID)[0]
				                    })
				                    .map(e, {
				                        "id": e.lineItem.id,
				                        "documentID": context.args.input.documentID,
				                        "productID": e.lineItem.productID,
				                        "quantity": e.lineItem.quantity,
				                        "name": isNull(e.lineItem.name) ? e.product.name : e.lineItem.name,
				                        "unitCost": isNull(e.lineItem.unitCost) ? e.product.unitCost : e.lineItem.unitCost,
				                        "unitPrice": isNull(e.lineItem.unitPrice) ? e.product.unitPrice : e.lineItem.unitPrice,
				                        "taxID": isNull(e.lineItem.taxID) ? e.product.taxID : e.lineItem.taxID,
				                        "taxRate": context.pipeline.getTaxes.filter(
				                                t, t.id == (
				                                    isNull(e.lineItem.taxID) ? 
				                                    e.product.taxID 
				                                    : e.lineItem.taxID
				                                    )
				                            )[0].taxRate
				                    })
				
				            }"""
		},
		{
			Name:        "createLineItems"
			Description: "Verify that the Document and LineItem records exist in the database before proceeding with the aggregation and update process."
			Test:        "size(context.pipeline.mappedData.toCreateLineItems) > 0"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.mappedData.toCreateLineItems"
			PreScript: """
				            {
				                "input": {
				                    "documentID": each.documentID,
				                    "productID": each.productID,
				                    "quantity": each.quantity,
				                    "name": each.name,
				                    "unitCost": each.unitCost,
				                    "unitPrice": each.unitPrice,
				                    "taxID": each.taxID,
				                    "taxAmount": decimal(each.unitPrice) * decimal(each.quantity) * decimal(each.taxRate),
				                    "totalAmount": null,
				                    "subtotalCost": null,
				                    "subtotalAmount": null,
				                    "isCalculated": false
				                }
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation createLineItem ($input: LineItemCreateInput!){
					                createLineItem(input: $input) {
					                    id
					                }
					                }"""
			}
			PostScript: """
				            {
				                "id": args.createLineItem.id
				            }"""
		},
		{
			Name:        "updateLineItems"
			Description: "Update the LineItem records in the database."
			Test:        "size(context.pipeline.mappedData.toUpdateLineItems) > 0"
			Invoker:     settings.adminInvoker
			PreScript: """
				            {
				                "input": context.pipeline.mappedData.toUpdateLineItems
				                    .map(e, {
				                        "id": e.id,
				                        "documentID": e.documentID,
				                        "productID": e.productID,
				                        "quantity": e.quantity,
				                        "name": e.name,
				                        "unitCost": e.unitCost,
				                        "unitPrice": decimal(e.unitPrice),
				                        "taxID": e.taxID,
				                        "taxAmount": decimal(e.unitPrice) * decimal(e.quantity) * decimal(e.taxRate),
				                        "totalAmount": null,
				                        "subtotalCost": null,
				                        "subtotalAmount": null,
				                        "isCalculated": false
				                    })
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation bulkUpsertLineItems($input: [LineItemCreateInput]) {
					                    bulkUpsertLineItems(input: $input) 
					                }"""
			}
			PostScript: """
				            {
				                "result": args.bulkUpsertLineItems
				            }"""
		},
	]
}
