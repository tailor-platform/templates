package resolvers

import (
	"{{ .Values.cue.package }}/charts/pipeline:settings"
	"github.com/tailor-inc/platform-core-services/api/gen/go/pipeline/v1:pipelinev1"
	schema "github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:pipeline"
)

calculatePutAwayLeadTime: pipelinev1.#Resolver & {
	authorization: "true"
	id: {{generateUUID | quote}}
	name:        "calculatePutAwayLeadTime"
	description: """
	The purpose of this Pipeline is to create a caluculation table for PutAway, then aggregate the caluculation table to caluculate the average lead time for each product, location, supplier combination, then store the result to SupplierLeadTime.
	This Pipeline follows the following steps:
	1. Get all the putAway records. Also in the same query, get all the putAwayCalc records and supplierLeadTime records to be deleted in the last step.
	2. Parse and flatten the putAway records in pre-script. Then store them in putAwayCalc.
	3. Aggregate the putAwayCalc records to caluculate the average lead time for each product, location, supplier combination.
	4. Create SupplierLeadTime records based on the result of the aggregation.
	5. Delete the putAwayCalc records and supplierLeadTime records created prior to the step 3 and 4. Those are the result of the step 1.
	"""
	postScript: """
	(!isNull(context.pipeline.createPutAwayCalc.result) || !isNull(context.pipeline.deletePutAwayLeadTimeCalc.result))
	&&
	(!isNull(context.pipeline.createSupplierLeadTime.result) || !isNull(context.pipeline.deleteSupplierLeadTime.result))
	"""
	response: { type: schema.Boolean }	
	pipeline: [
		{
			id: {{generateUUID | quote}}
			name:        "getRecords"
			description: "Get all the putAway records. Also in the same query, get all the putAwayCalc records and supplierLeadTime records to be deleted in the last step."
			url:         settings.services.gateway
			graphqlQuery: """
			query getRecords {
			  putAways {
			    collection {
			      id
			      quantity
				  putAwayDate
			      purchaseOrderID
			      purchaseOrder {
			        purchaseOrderDate
			        productID
			        locationID
			        supplierID
			      }
			    }
			  }
			  putAwayCalcs {
			    collection {
			      id
			    }
			  }
			  supplierLeadTimes{
			      collection{
			        id
			      }
			  }
			}"""
			postScript: """
			{
				"putAways": args.putAways,
				"putAwayCalcs": args.putAwayCalcs,
				"supplierLeadTimes": args.supplierLeadTimes,
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createPutAwayCalc"
			description: "Parse and flatten the putAway records in pre-script. Then store them in putAwayCalc."
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.putAways.collection"
			preScript: """
			{
				"putAwayID": each.id,
				"quantity": each.quantity,
				"putAwayDate": each.putAwayDate,
				"purchaseOrderID": each.purchaseOrderID,
				// flatten nested fields in purchaseOrder
				"productID": each.purchaseOrder.productID,
				"locationID": each.purchaseOrder.locationID,
				"supplierID": each.purchaseOrder.supplierID,
				"purchaseOrderDate": each.purchaseOrder.purchaseOrderDate,
			}
			"""
			graphqlQuery: """
			mutation putAwayCalc(
			  $putAwayID: ID!
			  $quantity: Int!
			  $putAwayDate: Date!
			  $purchaseOrderID: ID!
			  $productID: ID!
			  $locationID: ID!
			  $supplierID: ID!
			  $purchaseOrderDate: Date!
			) {
			  createPutAwayCalc: createPutAwayCalc(
			    input:{
					putAwayID:$putAwayID
					quantity:$quantity
					putAwayDate:$putAwayDate
					purchaseOrderID:$purchaseOrderID
					productID:$productID
					locationID:$locationID
					supplierID:$supplierID
					purchaseOrderDate:$purchaseOrderDate
			  	}){
			    id
			  }
			}"""
			postScript: """
			{
				"result": args.createPutAwayCalc
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "aggregatePutAwayCalcs"
			description: "Aggregate the putAwayCalc records to caluculate the average lead time for each product, location, supplier combination."
			url:         settings.services.gateway
			graphqlQuery: """
			query aggregatPputAwayCalcs	{
			  aggregatePutAwayCalcs{
			    groupBy{
			      productID
			      locationID
			      supplierID
			    }
			    avg{
			      leadTime
			    }
			  }
			}"""
			postScript: """
			{
				"result": args.aggregatePutAwayCalcs
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "createSupplierLeadTime"
			description: "Create SupplierLeadTime records based on the result of the aggregation."
			url:         settings.services.gateway
			forEach:	 "args.result"
			preScript: """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"supplierID": each.groupBy.supplierID,
					"averageLeadTime": each.avg.leadTime,
				}
			}"""
			graphqlQuery: """
			mutation ($input: SupplierLeadTimeCreateInput) {
			  createSupplierLeadTime(input: $input) {
			    id
			  }
			}"""
			postScript: """
			{
				"result": args.createSupplierLeadTime
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deletePutAwayLeadTimeCalc"
			description: "Delete the putAwayCalc records created prior to createPutAwayCalc. Those records are the result of the step getRecords.putAwayCalcs."
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.putAwayCalcs.collection"
			test: 		 "size(context.pipeline.getRecords.putAwayCalcs.collection) > 0" // skip if there is no record to delete.
			preScript: """
			{
				"id": each.id,
			}
			"""
			graphqlQuery: """
			mutation deletePutAwayCalc($id: ID!) {
			  deletePutAwayCalc(id: $id)
			}"""
			postScript: """
			{
				"result": args.deletePutAwayCalc
			}"""
		},
		{
			id: {{generateUUID | quote}}
			name:        "deleteSupplierLeadTime"
			description: "Delete the SupplierLeadTime records created prior to createSupplierLeadTime. Those records are the result of the step getRecords.supplierLeadTimes."
			url:         settings.services.gateway
			forEach:	 "context.pipeline.getRecords.supplierLeadTimes.collection"
			test: 		 "size(context.pipeline.getRecords.supplierLeadTimes.collection) > 0" // skip if there is no record to delete.
			preScript: """
			{
				"id": each.id,
			}
			"""
			graphqlQuery: """
			mutation deletePutAwayLeadTimeCalc($id: ID!) {
			  deleteSupplierLeadTime(id: $id)
			}"""
			postScript: """
			{
				"result": args.deleteSupplierLeadTime
			}"""
		},
	]
}
