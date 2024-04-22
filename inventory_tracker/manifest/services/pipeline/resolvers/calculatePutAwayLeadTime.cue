package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "tailor.build/template/manifest/services/pipeline:settings"
)

calculatePutAwayLeadTime: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:        "calculatePutAwayLeadTime"
	Description: """
	The purpose of this Pipeline is to create a calculation table for PutAway, then aggregate the calculation table to calculate the average lead time for each product, location, supplier combination, then store the result to SupplierLeadTime.
	This Pipeline follows the following steps:
	1. Get all the putAway records. Also in the same query, get all the putAwayCalc records and supplierLeadTime records to be deleted in the last step.
	2. Parse and flatten the putAway records in pre-script. Then store them in putAwayCalc.
	3. Aggregate the putAwayCalc records to calculate the average lead time for each product, location, supplier combination.
	4. Create SupplierLeadTime records based on the result of the aggregation.
	5. Delete the putAwayCalc records and supplierLeadTime records created prior to the step 3 and 4. Those are the result of the step 1.
	"""
	PostScript: """
	(!isNull(context.pipeline.createPutAwayCalc.result) || !isNull(context.pipeline.deletePutAwayLeadTimeCalc.result))
	&&
	(!isNull(context.pipeline.createSupplierLeadTime.result) || !isNull(context.pipeline.deleteSupplierLeadTime.result))
	"""
	Response: { Type: pipeline.Boolean }	
	Pipelines: [
		{
			Name:        "getRecords"
			Description: "Get all the putAway records. Also in the same query, get all the putAwayCalc records and supplierLeadTime records to be deleted in the last step."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
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
			}
			PostScript: """
			{
				"putAways": args.putAways,
				"putAwayCalcs": args.putAwayCalcs,
				"supplierLeadTimes": args.supplierLeadTimes,
			}"""
		},
		{
			Name:        "createPutAwayCalc"
			Description: "Parse and flatten the putAway records in pre-script. Then store them in putAwayCalc."
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.putAways.collection"
			PreScript: """
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
			Operation: pipeline.#GraphqlOperation & {
				Query: """
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
			}
			PostScript: """
			{
				"result": args.createPutAwayCalc
			}"""
		},
		{
			Name:        "aggregatePutAwayCalcs"
			Description: "Aggregate the putAwayCalc records to calculate the average lead time for each product, location, supplier combination."
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
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
			}
			PostScript: """
			{
				"result": args.aggregatePutAwayCalcs
			}"""
		},
		{
			Name:        "createSupplierLeadTime"
			Description: "Create SupplierLeadTime records based on the result of the aggregation."
			Invoker:     settings.adminInvoker
			ForEach:	 "args.result"
			PreScript: """
			{
				"input": {
					"productID": each.groupBy.productID,
					"locationID": each.groupBy.locationID,
					"supplierID": each.groupBy.supplierID,
					"averageLeadTime": each.avg.leadTime,
				}
			}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation ($input: SupplierLeadTimeCreateInput) {
					createSupplierLeadTime(input: $input) {
						id
					}
				}"""
			}
			PostScript: """
			{
				"result": args.createSupplierLeadTime
			}"""
		},
		{
			Name:        "deletePutAwayLeadTimeCalc"
			Description: "Delete the putAwayCalc records created prior to createPutAwayCalc. Those records are the result of the step getRecords.putAwayCalcs."
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.putAwayCalcs.collection"
			Test: 		 "size(context.pipeline.getRecords.putAwayCalcs.collection) > 0" // skip if there is no record to delete.
			PreScript: """
			{
				"id": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deletePutAwayCalc($id: ID!) {
			  		deletePutAwayCalc(id: $id)
				}"""
			}
			PostScript: """
			{
				"result": args.deletePutAwayCalc
			}"""
		},
		{
			Name:        "deleteSupplierLeadTime"
			Description: "Delete the SupplierLeadTime records created prior to createSupplierLeadTime. Those records are the result of the step getRecords.supplierLeadTimes."
			Invoker:     settings.adminInvoker
			ForEach:	 "context.pipeline.getRecords.supplierLeadTimes.collection"
			Test: 		 "size(context.pipeline.getRecords.supplierLeadTimes.collection) > 0" // skip if there is no record to delete.
			PreScript: """
			{
				"id": each.id,
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation deletePutAwayLeadTimeCalc($id: ID!) {
					deleteSupplierLeadTime(id: $id)
				}"""
			}
			PostScript: """
			{
				"result": args.deleteSupplierLeadTime
			}"""
		},
	]
}
