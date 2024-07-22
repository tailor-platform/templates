package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"

)

transferBinStock: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "transferBinStock"
	Description: """

		Steps:
		1. Fetch the BinStock record by UUID, provided as the input.fromBinStock (binStock)
		2. Check if the quantity, provided as the input equals to or less than the quantity of the "from" BinStock.quantity. Return error and exit if not.
		3. Check if the same product exists in the toBin. If it does, the BinStockID will be used in the next steps. (bin)
		4. If the same product does not exist in the Bin specified in the previous step, create a new record (createToBinStock)
		5. If the same product already exists in the Bin, update the BinStock record quantity to (BinStock.quantity + input.quantity) (updateBinStock)
		6. To reduce the quantity of the fromBinStock, if input.quantity = BinStock.quantity, delete the BinStock record (deleteBinStock)
		7. If input.quantity < BinStock.quantity, update the BinStock.quantity to (BinStock.quantity - input.quantity) (updateBinStock)
		"""
	Response: {Type: pipeline.Boolean}
	PostScript: "context.pipeline.fetchFromBinStock.isValid"
	Inputs: [
		{Name: "input"
			Required: true
			Type: {
				Name: "transferBinStockInput"
				Fields: [
					{Name: "fromBinStockID", Type: pipeline.ID, Required: true},
					{Name: "toBinID", Type: pipeline.ID, Required: true},
					{Name: "quantity", Type: pipeline.Int, Required: true},
				]
			}
		},
	]
	Pipelines: [
		// 1. Fetch the BinStock record by UUID, provided as the input.fromBinStock (binStock)
		// 2. Check if the quantity, provided as the input equals to or less than the quantity of the "from" BinStock.quantity. Return error and exit if not.
		{
			Name:        "fetchFromBinStock"
			Description: "Fetch the BinStock record by UUID, provided as the input (binStock)"
			PreScript:   "context.args.input"
			Invoker:     settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query binStock($fromBinStockID: ID!){
					                    binStock(id: $fromBinStockID){
					                        id
					                        binID
					                        productID
					                        quantity
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.binStock,
				                "isValid": isNull(args.binStock)? false : int(context.args.input.quantity) <= int(args.binStock.quantity)
				            }"""
		},
		// 3. Check if the same product exists in the toBin. If it does, the BinStockID will be used in the next steps. (bin)
		{
			Name:        "fetchToBinStock"
			Description: "Check if the same product exists in the toBin."
			Test:        "context.pipeline.fetchFromBinStock.isValid && !isNull(context.pipeline.fetchFromBinStock.result)" // Check if the BinStock record exists
			PreScript: """
				            {
				                "productID": context.pipeline.fetchFromBinStock.result.productID,
				                "binID": context.args.input.toBinID
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                query binStocks ($productID: ID!, $binID: ID!) {
					                    binStocks (query: {productID: {eq: $productID}, binID: {eq: $binID}}){
					                        collection{
					                            id
					                            binID
					                            productID
					                            quantity
					                        }
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": size(args.binStocks.collection) > 0 ? args.binStocks.collection[0] : null
				            }"""
		},
		// 4. If the same product does not exist in the Bin specified in the previous step, create a new record (createToBinStock)
		{
			Name:        "createToBinStock"
			Description: "If the same product does not exist in the Bin specified in the previous step, create a new record (createToBinStock)"
			Test:        "context.pipeline.fetchFromBinStock.isValid && isNull(context.pipeline.fetchToBinStock.result)" // Create a new BinStock record only if the BinStock record does not exist
			PreScript: """
				            {
				                "input": compact({
				                    "binID": context.args.input.toBinID,
				                    "productID": context.pipeline.fetchFromBinStock.result.productID,
				                    "quantity": int(context.args.input.quantity)
				                })
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation createBinStock($input: BinStockCreateInput!) {
					                    createBinStock(input: $input) {
					                        id
					                        binID
					                        productID
					                        quantity
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.createBinStock
				            }"""
		},
		// 5. If the same product already exists in the Bin, update the BinStock record quantity to (BinStock.quantity + input.quantity) (updateBinStock)
		{
			Name:        "updateToBinStock"
			Description: "If the same product already exists in the Bin, update the BinStock record quantity to (BinStock.quantity + input.quantity) (updateBinStock)"
			Test:        "context.pipeline.fetchFromBinStock.isValid && !isNull(context.pipeline.fetchToBinStock.result)" // Update the BinStock record only if the BinStock record exists
			PreScript: """
				            {
				                "id": context.pipeline.fetchToBinStock.result.id,
				                "input": compact({
				                    "quantity": int(context.pipeline.fetchToBinStock.result.quantity) + int(context.args.input.quantity)
				                })
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation updateBinStock($id: ID!, $input: BinStockUpdateInput!) {
					                    updateBinStock(id: $id, input: $input) {
					                        id
					                        binID
					                        productID
					                        quantity
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.updateBinStock
				            }"""
		},
		// 6. To reduce the quantity of the fromBinStock, if input.quantity = BinStock.quantity, delete the BinStock record (deleteBinStock)
		{
			Name:        "deleteFromBinStock"
			Description: "To reduce the quantity of the fromBinStock, if input.quantity = BinStock.quantity, delete the BinStock record (deleteBinStock)"
			Test:        "context.pipeline.fetchFromBinStock.isValid && context.pipeline.fetchFromBinStock.result.quantity == context.args.input.quantity" // Delete the BinStock record only if the BinStock record exists
			PreScript: """
				            {
				                "id": context.pipeline.fetchFromBinStock.result.id
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation deleteBinStock($id: ID!) {
					                    deleteBinStock(id: $id)
					                }"""
			}
			PostScript: """
				            {
				                "result": args.deleteBinStock
				            }"""
		},

		// 7. If input.quantity < BinStock.quantity, update the BinStock.quantity to (BinStock.quantity - input.quantity) (updateBinStock)
		{
			Name:        "updateFromBinStock"
			Description: "If input.quantity < BinStock.quantity, update the BinStock.quantity to (BinStock.quantity - input.quantity) (updateBinStock)"
			Test:        "context.pipeline.fetchFromBinStock.isValid && context.pipeline.fetchFromBinStock.result.quantity > context.args.input.quantity" // Update the BinStock record only if the BinStock record exists
			PreScript: """
				            {
				                "id": context.pipeline.fetchFromBinStock.result.id,
				                "input": compact({
				                    "quantity": int(context.pipeline.fetchFromBinStock.result.quantity) - int(context.args.input.quantity)
				                })
				            }"""
			Invoker: settings.adminInvoker
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                mutation updateBinStock($id: ID!, $input: BinStockUpdateInput!) {
					                    updateBinStock(id: $id, input: $input) {
					                        id
					                        binID
					                        productID
					                        quantity
					                    }
					                }"""
			}
			PostScript: """
				            {
				                "result": args.updateBinStock
				            }"""
		},
	]
}
