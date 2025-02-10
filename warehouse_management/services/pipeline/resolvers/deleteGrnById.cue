package resolvers

import (
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

deleteGrnById: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "deleteGrnById"
	Description: """
		  Delete a GoodsReceivedNote record by ID. And clean up related line items.
		"""
	Response: {
    Type: pipeline.Boolean
  }
	PostScript: """
		!isNull(context.pipeline.deleteGrn)
	"""
	Inputs: [
		{Name: "id"
			Required: true
			Type:     pipeline.ID
		},
	]
	Pipelines: [
		{
			Name:        "fetchGrnLineItems"
			Description: "Fetch the GoodsReceivedNoteLineItem records by GoodsReceivedNote ID, provided as the input (id)"
			PreScript:   "context.args"
			Invoker:     settings.adminInvoker
			Operation:   pipeline.#GraphqlOperation & {
				Query: """
					query goodsReceivedNoteLineItems($id: ID!){
						goodsReceivedNoteLineItems(query: {goodsReceivedNoteID: {eq: $id}}){
							edges {
								node {
									id
								}
							}
						}
					}"""
			}
			PostScript: """
				  args.goodsReceivedNoteLineItems.edges
				"""
		},
		{
			Name:        "deleteGrnLineItems"
			Description: "Delete the GoodsReceivedNoteLineItem records"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchGrnLineItems"
			PreScript: """
				{
					"id": each.node.id
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation deleteGoodsReceivedNoteLineItem($id: ID!){
						deleteGoodsReceivedNoteLineItem(id: $id)
					}"""
			}
		},
		{
			Name:        "deleteGrn"
			Description: "Delete the GoodsReceivedNote record by ID, provided as the input (id)"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation:   pipeline.#GraphqlOperation & {
				Query: """
					mutation deleteGoodsReceivedNote($id: ID!){
						deleteGoodsReceivedNote(id: $id)
					}"""
			}
		},
	]
}
