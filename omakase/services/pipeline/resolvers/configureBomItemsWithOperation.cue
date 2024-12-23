package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

configureBomItemsWithOperationOutput : {
	Name: "configureBomItemsWithOperationOutput",
	Fields: [
		{Name: "success", Type: pipeline.Boolean, Required: true},
	],
}

configureBomItemsWithOperation : pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure,
	Name:          "configureBomItemsWithOperation",
	Description: """
	Configures BOM items with operations.
	""",
	Response: {Type: configureBomItemsWithOperationOutput},
	Inputs: [
		{
			Name:     "input",
			Required: true,
			Type: {
				Name: "configureBomItemsWithOperationInput",
				Fields: [
					{Name: "bomId", Type: pipeline.ID, Required: true},
				],
			},
		},
	],
	Pipelines: [
		{
			Name:        "fetchBomData",
			Description: "Fetches BOM, BOM line items, operations, and operation line items.",
			PreScript: """
			{
				"bomId": context.args.input.bomId
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
			query fetchBomData($bomId: ID!) {
				bom(id: $bomId) {
					id
				}
				bomLineItems(query: {bomId: {eq: $bomId}}) {
					collection {
						id
						inputQuantity
						itemId
						returnAsNewSkuItemId
						scrapAction
					}
				}
				operations(query: {bomId: {eq: $bomId}, isActive: {eq: true} }, order: {field: order, direction: Asc}) {
					collection {
						id
						name
					}
				}
				operationLineItems(query: {bomId: {eq: $bomId}}) {
					collection {
						id
						quantity
						operationId
					}
				}
			}
			"""
			},
			PostHook: common.#Script & {
				Expr: """
			(() => {
				const bom = args.bom;
				const bomLineItems = args.bomLineItems.collection;
				const operations = args.operations.collection;
				const operationLineItems = args.operationLineItems.collection;

				if (!bom || !bom.id) {
					return {
						success: false,
						message: 'BOM not found.'
					};
				}

				if (operations.length === 0) {
					return {
						success: false,
						message: 'Operations not found.'
					};
				}

				if (bomLineItems.length === 0) {
					return {
						success: false,
						message: 'BOM Line Items not found.'
					};
				}

				if (operationLineItems.length > 0) {
					return {
						success: false,
						message: 'Operation Line Items already exist.'
					};
				} 

				// Map all BOM Line Items with the first operation
				const firstOperation = operations[0];
				const bulkInput = bomLineItems.map(bomLineItem => ({
					operationId: firstOperation.id,
					bomLineItemId: bomLineItem.id,
					bomId: bom.id,
					quantity: bomLineItem.inputQuantity,
					returnAsNewSkuItemId: bomLineItem.returnAsNewSkuItemId || null,
					scrapAction: bomLineItem.scrapAction || null,
				}));

				return {
					success: true,
					bulkInput: bulkInput
				};
			})()
			"""
			},
			PostValidation: """
			!context.pipeline.fetchBomData.success ?
			context.pipeline.fetchBomData.message :
			''
			"""
		},
		{
			Name:        "bulkUpsertOperationLineItems",
			Description: "Creates operation line items by bulk upserting.",
			PreScript: """
			{
				"input": context.pipeline.fetchBomData.bulkInput
			}
			""",
			Operation: pipeline.#GraphqlOperation & {
				Query: """
			mutation bulkUpsertOperationLineItems($input: [OperationLineItemCreateInput!]!) {
				bulkUpsertOperationLineItems(input: $input)
			}
			"""
			}
		}
	],
	PostScript: """
	{
		"success": true
	}
	"""
}