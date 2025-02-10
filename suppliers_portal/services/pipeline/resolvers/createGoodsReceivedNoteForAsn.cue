package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings"
)

createGoodsReceivedNoteForAsnInput: {
	Name: "CreateGoodsReceivedNoteForAsnInput"
	Fields: [
		{
			Name: "supplierID"
			Type: pipeline.ID
		},
		{
			Name: "invoiceID"
			Type: pipeline.ID
		},
		{
			Name: "advanceShipmentNoticeID"
			Type: pipeline.ID
		},
		{
			Name: "grnDate"
			Type: pipeline.Date
		},
		{
			Name: "reference"
			Type: pipeline.String
		},
		{
			Name: "status"
			Type: pipeline.String
		},
	]
}

createGoodsReceivedNoteForAsn: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "createGoodsReceivedNoteForAsn"
	Description:   "Generating a GRN from an ASN and connect line items"
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type:     createGoodsReceivedNoteForAsnInput
		},
	]
	Response: {
		Type: pipeline.ID
	}
	PostScript: "context.pipeline.createGoodsReceivedNote.id"
	Pipelines: [
		{
			Name:        "fetchAdvanceShipmentNoticeLineItems"
			Description: "Get line items from ASN"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args.input"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
															  query fetchAdvanceShipmentNoticeLineItems($advanceShipmentNoticeID: ID!) {
															    advanceShipmentNoticeLineItems(query: {advanceShipmentNoticeID: { eq: $advanceShipmentNoticeID}}) {
															      edges {
																			node {
																				id
																				displayOrder
																				product {
																					id
																					name
																					description
																					price
																				}
																				invoiceLineItemID
																				productID
																				quantity
																			}
															      }
															    }
															  }"""
			}
			PostScript: "args.advanceShipmentNoticeLineItems.edges"
		},
		{
			Name:        "createGoodsReceivedNote"
			Description: "Create a new GRN"
			Invoker:     settings.adminInvoker
			PreScript:   "context.args"
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					                    mutation ($input: GoodsReceivedNoteCreateInput!) {
					                        createGoodsReceivedNote(input: $input) {
					                          id
					                          supplierID
					                          invoiceID
					                          advanceShipmentNoticeID
					                          grnDate
					                          reference
					                          status
					                        }
					                      }"""
			}
			PostScript: "args.createGoodsReceivedNote"
		},
		{
			Name:        "createGoodsReceivedNoteLineItems"
			Description: "Create line items for the ASN"
			Invoker:     settings.adminInvoker
			ForEach:     "context.pipeline.fetchAdvanceShipmentNoticeLineItems"
			PreScript: """
																{
																  "input": {
																    "displayOrder": each.node.displayOrder,
																    "goodsReceivedNoteID": context.pipeline.createGoodsReceivedNote.id,
																    "advanceShipmentNoteLineItemID": each.node.id,
												            "invoiceLineItemID": each.node.invoiceLineItemID,
																    "productID": each.node.productID,
																    "quantity": each.node.quantity,
																  }
																}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					  mutation ($input: GoodsReceivedNoteLineItemCreateInput!) {
					    createGoodsReceivedNoteLineItem(input: $input) {
					      id
					    }
					  }
					"""
			}
			PostScript: "args.createGoodsReceivedNoteLineItem.id"
		},
	]
}
