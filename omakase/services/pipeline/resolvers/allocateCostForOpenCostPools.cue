package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

allocateCostForOpenCostPools: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "allocateCostForOpenCostPools"
	Description: """
		This pipeline allocates cost for all the open cost pools.
		Steps
		1. Query the open cost pools  
		2. Run allocateCost for each one
		"""
	Response: {Type: pipeline.String}
	PostScript: "'COST POOL ALLOCATED FOR ' + string(size(context.pipeline.getOpenCostPools)) + ' COST POOLS'"
	Pipelines: [
		{
			Name:        "getOpenCostPools"
			Description: "Fetch all the open cost pools"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					query  {
					    costPools(query: { isClosed: { eq: false } }) {
					        collection{
					            id
					        }
					    }
					}
					"""
			}
			PostScript: "args.costPools.collection"
		},
		{
			Name:        "getReceipts"
			Description: "Get all receipts with open cost pools"
			Invoker:     settings.adminInvoker
			PreScript: """
				            {
				                "costPoolIDs": context.pipeline.getOpenCostPools.map(e, e.id),
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					query  ( $costPoolIDs: [ID]!) {
					    receiptLineItems(query: { costPools: { costPoolID: {in: $costPoolIDs } } }) {
					        collection {
					            id
					        }
					    }
					}
					"""
			}
			PostScript: "isNull(args.receiptLineItems.collection)? [] : args.receiptLineItems.collection"
		},
		{
			Name:        "setReceiptLineItemsToZero"
			Description: "Set the totalCostPoolAllocation to zero for all the receipt line items"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getReceipts"
			PreScript: """
				            {
				                "id": each.id,
				                "input" : compact({
				                    "totalCostPoolAllocation": decimal(0.0)
				                })
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($id: ID!, $input: ReceiptLineItemUpdateInput!) {
					    updateReceiptLineItem(id: $id, input: $input) {
					        id
					    }
					}
					"""
			}
		},
		{
			Name:        "allocateCost"
			Description: "allocate cost for each cost pool"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.getOpenCostPools"
			PreScript: """
				            {
				                "costPoolID": each.id,
				            }"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation($costPoolID: ID!){
					    allocateCost(
					        input:{
					            costPoolID: $costPoolID
					        }
					    )
					}
					"""
			}
			PostScript: "args.allocateCost"
		},
	]
}
