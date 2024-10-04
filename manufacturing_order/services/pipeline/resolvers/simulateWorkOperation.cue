package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

simulateWorkOperationOutput: {
	Name: "simulateWorkOperationOutput"
	Fields: [
		{Name: "outputQuantity", Type: pipeline.Float, Required: true},
		{
			Name:  "result"
			Array: true
			Type: {
				Name: "listPickingOperationResult"
				Fields: [
					{Name: "id", Type: pipeline.ID},
					{Name: "duration", Type: pipeline.Float},
					{Name: "order", Type: pipeline.Int},
					{Name: "calculatedDuration", Type: pipeline.Float},
					{Name: "documentUrl", Type: pipeline.String},
					{Name: "description", Type: pipeline.String},
					{Name: "name", Type: pipeline.String},
					{Name: "isActive", Type: pipeline.Boolean},
					{Name: "workCenterId", Type: pipeline.ID},
					{Name: "workCenter", Type: pipeline.String},
				]
			}
		},
	]
}

simulateWorkOperation: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "simulateWorkOperation"
	Description:   "Simulate the work Operation required for given bill of material"
	Response: {Type: simulateWorkOperationOutput}
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "simulateWorkOperationInput"
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
					{Name: "outputQuantity", Type: pipeline.Float, Required: true},
				]
			}
		},
	]
	Pipelines: [
		{
			Name:        "fetchOperations"
			Description: "Fetch all Operations"
			PreScript: """
					{
						'bomId': context.args.input.bomId
					}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
						query fetchOperations($bomId: ID!) {
							operations(
								query: {bomId: {eq:$bomId}, isActive: {eq: true}}
							) {
								collection {
									id
									duration
									workCenterId
									documentUrl
									description
									name
									order
									isActive
									workCenter {
										name
										timeEfficiency
										parallelProcessingLimit
										setupTime
										cleanupTime
									}
								}
							}
						}"""
			}
			PostHook: common.#Script & {
				Expr: """
					(() => {
						const operations = args.operations;
						const outputQuantity = context.args.input.outputQuantity;
						const result = args.operations.collection.length == 0 ? [] : args.operations.collection.map(e=> ({
							"id": e.id,
							"duration": e.duration,
							"order": e.order,
							"documentUrl": e.documentUrl,
							"description": e.description,
							"name": e.name,
							"isActive": e.isActive,
							"workCenterId": e.workCenterId,
							"workCenter": e.workCenter.name,
							"calculatedDuration": Math.floor(e.workCenter.setupTime + e.workCenter.cleanupTime + ((Math.floor(outputQuantity / e.workCenter.parallelProcessingLimit) + (outputQuantity % e.workCenter.parallelProcessingLimit)) * e.duration * 100 / (e.workCenter.timeEfficiency * 100)))
						}));

						return {
							operations,
							outputQuantity,
							result
						}
					})()
				"""
			}
			PostValidation: """
					size(context.pipeline.fetchOperations.operations.collection) == 0 ?
					['No operations found for ',context.args.input.bomId].join(''):
					''
				"""
		},
	]
}
