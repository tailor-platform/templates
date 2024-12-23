package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/environment"
	"tailor.build/template/services/pipeline:settings"
)

allocateCost: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "allocateCost"
	Description: """
		    This pipeline allocates cost to a specific cost pool based on the cost pool type.
		    Steps:  
		    1. Query the cost pool in the input  
		    2. Query all receipts for this cost pool
		    3. Based on the previous result and the costpoolLI type, allocate costs to receipt line items related
		    4. Update in the the ReceiptLineItems with the results in step 3"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "allocateCostInput"
				Fields: [
					{Name: "costPoolID", Type: pipeline.ID, Required: true},
				]
			}
		},
	]
	Response: {Type: pipeline.String}
	PostScript: "'COST POOL ALLOCATED'"
	Pipelines: [
		{
			Name:        "getReceiptAndCostPoolData"
			Description: "Fetch all the open cost pools"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					query  ( $costPoolID: ID!) {
					    receiptLineItems(query: { costPools: { costPoolID: {eq: $costPoolID } } }) {
					        collection {
					            id
					            subtotalCost
					            totalCostPoolAllocation
					            cubicMeters
					            variantID
					            quantity
					            subtotalUnitCost
					            receiptID
					            costPools {
					                costPoolID
					            }
					        }
					    }
					    costPool(id: $costPoolID) {
					        isClosed
					        id
					        name
					    }
					    volumeAllocation: aggregateCostPoolLineItems (
					        query: { 
					            costPoolID: { eq: $costPoolID },
					            allocationBase: { eq: VOLUME }    
					        }
					    ) {
					        sum {
					            amount
					        }
					    }
					    amountAllocation: aggregateCostPoolLineItems (
					        query: { 
					            costPoolID: { eq: $costPoolID },
					            allocationBase: { eq: DOLLAR_AMOUNT }    
					        }
					    ) {
					        sum {
					            amount
					        }
					    }
					    aggregateReceiptLineItems (query: { costPools: { costPoolID: {eq: $costPoolID} } }) {
					        sum {
					            subtotalCost
					            cubicMeters
					        }
					    }
					}
					"""
			}
			PostScript: """
				            {
				                "availableAmount": isNull(args.aggregateReceiptLineItems[0].sum.subtotalCost) ? 0.0 : decimal(args.aggregateReceiptLineItems[0].sum.subtotalCost),
				                "availableCubicMeters": isNull(args.aggregateReceiptLineItems[0].sum.cubicMeters) ? 0.0 : decimal(args.aggregateReceiptLineItems[0].sum.cubicMeters),
				                "receiptLineItems": args.receiptLineItems.collection.map(rli, {
				                    "id": rli.id,
				                    "subtotalCost": rli.subtotalCost,
				                    "cubicMeters": isNull(rli.cubicMeters) ? 0.0 : decimal(rli.cubicMeters),
				                    "variantID": rli.variantID,
				                    "quantity": isNull(rli.quantity) ? 0 : rli.quantity,
				                    "subtotalUnitCost": isNull(rli.subtotalUnitCost) ? 0.0 : decimal(rli.subtotalUnitCost),
				                    "receiptID": rli.receiptID,
				                    "totalCostPoolAllocation": isNull(rli.totalCostPoolAllocation) ? decimal(0.0) : decimal(rli.totalCostPoolAllocation),
				                }),
				                "volumeAllocation": isNull(args.volumeAllocation[0].sum.amount) ? 0.0 : decimal(args.volumeAllocation[0].sum.amount),
				                "amountAllocation": isNull(args.amountAllocation[0].sum.amount) ? 0.0 : decimal(args.amountAllocation[0].sum.amount),
				                "costPool": args.costPool
				            }"""
			PostValidation: """
				context.pipeline.getReceiptAndCostPoolData.costPool.isClosed == true ?
				"Cost pool is closed" :
				""
				"""
		},
		{
			Name:        "updateReceiptLineItems"
			Description: "Fetch all the open cost pools"
			Invoker:     settings.adminInvoker
			Test:        "size(context.pipeline.getReceiptAndCostPoolData.receiptLineItems) > 0"
			PreScript: """
				{
				    "input": context.pipeline.getReceiptAndCostPoolData.receiptLineItems.map(rli, {
				            "id": rli.id,
				            "subtotalCost": rli.subtotalCost,
				            "cubicMeters": rli.cubicMeters,
				            "variantID": rli.variantID,
				            "quantity": rli.quantity,
				            "subtotalUnitCost": rli.subtotalUnitCost,
				            "receiptID": rli.receiptID,
				            "totalCostPoolAllocation":
				                (
				                    ( 
				                        context.pipeline.getReceiptAndCostPoolData.availableCubicMeters != 0.0 ? 
				                        decimal(rli.cubicMeters) / decimal(context.pipeline.getReceiptAndCostPoolData.availableCubicMeters) :
				                        decimal(0.0)
				                    ) * decimal(context.pipeline.getReceiptAndCostPoolData.volumeAllocation)
				                ) +
				                (
				                    (
				                        context.pipeline.getReceiptAndCostPoolData.availableAmount != 0.0 ? 
				                        decimal(rli.subtotalCost) / decimal(context.pipeline.getReceiptAndCostPoolData.availableAmount) :
				                        decimal(0.0)
				                    ) * decimal(context.pipeline.getReceiptAndCostPoolData.amountAllocation)
				                ) +
				                decimal(rli.totalCostPoolAllocation)
				        })
				}
				"""
			Operation: pipeline.#GraphqlOperation & {
				AppName: environment.#app.namespace
				Query: """
					mutation ($input: [ReceiptLineItemCreateInput]) {
					    bulkUpsertReceiptLineItems(input: $input)
					}
					"""
			}
		},
	]
}
