package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

calculateStockEventCalc: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "calculateStockEventCalc"
	description: """
	The purpose of this Pipeline is to create a calculation table for StockEvents.
	This Pipeline follows the following steps:
	1. Get all the StockEvent records. Also in the same query, get all the StockEventCalc records to be deleted in the last step.
	2. Parse and flatten the StockEvent records in pre-script. Then store them in StockEventCalc.
	3. Delete the StockEventCalc records created prior to the step 2.
	"""
	response: { type: schema.Boolean }
	postScript: """
	size(context.pipeline.createStockEventCalc)>0 || size(context.pipeline.deleteStockEventCalc)>0
	"""
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getRecords"
			description: "Get all the StockEvent records. Also in the same query, get all the StockEventCalc records to be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
			query getRecords {
			  stockEvents {
			    collection {
			      id
			      eventDate
				  incrementalQuantity
				  reason
			      lotID
			      lot {
			        putAway {
			          id
					  quantity
					  putAwayDate
			          purchaseOrderID
			          purchaseOrder {
			            productID
			            product {
			              sellingStartDate
			            }
			            locationID
						supplierID
			          }
			        }
			      }
			    }
			  }
			  stockEventCalcs{
			    collection{
			      id
			    }
			  }
			}"""
			postScript: """
			{
				"stockEvents": args.stockEvents,
				"stockEventCalcs": args.stockEventCalcs,
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createStockEventCalc"
			description: "Parse and flatten the StockEvent records in pre-script. Then store them in StockEventCalc."
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.stockEvents.collection"
			preScript: """
			{
				"stockEventID": each.id,
				"purchaseOrderID": each.lot.putAway.purchaseOrderID,
				"putAwayID": each.lot.putAway.id,
				"productID": each.lot.putAway.purchaseOrder.productID,
				"locationID": each.lot.putAway.purchaseOrder.locationID,
				"lotID": each.lotID,
				"eventDate": each.eventDate,
				"sellingStartDate": each.lot.putAway.purchaseOrder.product.sellingStartDate,
				"incrementalQuantity": each.incrementalQuantity,
				"reason": each.reason,
			}"""
			graphqlQuery: """
			mutation (
			  $stockEventID: ID!
			  $purchaseOrderID: ID!
			  $putAwayID: ID!
			  $productID: ID!
			  $locationID: ID!
			  $lotID: ID!
			  $eventDate: Date!
			  $sellingStartDate: Date!
			  $incrementalQuantity: Int!
			  $reason: String!
			) {
			  createStockEventCalc(
			    input: {
			      stockEventID: $stockEventID
			      purchaseOrderID: $purchaseOrderID
			      putAwayID: $putAwayID
			      productID: $productID
			      locationID: $locationID
			      lotID: $lotID
			      eventDate: $eventDate
			      sellingStartDate: $sellingStartDate
			      incrementalQuantity: $incrementalQuantity
			      reason: $reason
			    }
			  ) {
			    id
			  }
			}"""
			postScript: """
				args.createStockEventCalc
			"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteStockEventCalc"
			description: "Delete the StockEventCalc records created prior to the step 2"
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.stockEventCalcs.collection"
			test: 		 "size(context.pipeline.getRecords.stockEventCalcs.collection) > 0" // skip if no records are found
			preScript: """
			{
				"stockEventCalcID": each.id,
			}
			"""
			graphqlQuery: """
			mutation deleteStockEventCalc($stockEventCalcID: ID!) {
			  deleteStockEventCalc(id: $stockEventCalcID)
			}"""
			postScript: """
				args.deleteStockEventCalc
			"""
		},
	]
}
