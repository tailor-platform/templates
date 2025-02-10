package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/services/pipeline:settings"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"encoding/json"
)

// Here add the attributes to nullify for each table,
// This helps to remove the dependency between tables
#nullifyAttributes: {
	Item: ["bomId"]
}

// Here add the table name and its plural form
#tables: {
	BomLineItem: "bomLineItems"
	Bom: "boms"
	Item: "items"
	UomConversion: "uomConversions"
	Uom: "uoms"
	Role: "roles"
	User: "users"
}

deleteAllTailorDBRecords: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "deleteAllTailorDBRecords"
	Description: """
		DANGER: Delete all the records in the database. This is a resolver for development purpose only.
		"""
	Response: {Type: pipeline.String}
	PostScript: "'RECORDS DELETED'"
	Pipelines: [
		for table, plural in #tables {
			{
				Name:        "get\(table)"
				Description: "Get all the \(table) records."
				Invoker:     settings.adminInvoker
				Operation: pipeline.#GraphqlOperation & {
					Query: """
                    query {
                        \(plural)(first: 1000){
                            edges{
								node
								{
                                	id
                            	}
							}
                        }
                    }"""
				}
				PostScript: """
                {
                    "items": args.\(plural).edges
                }"""
			}
		},
		for table, attributes in #nullifyAttributes {
			{
				Name: 	    "nullify\(table)"
				Description: "Nullify the attributes of \(table) records"
				Invoker:     settings.adminInvoker
				ForEach:     "context.pipeline.get\(table).items"
				Test:        "size(context.pipeline.get\(table).items) > 0" // skip if no records are found
				ContextData: json.Marshal(#nullifyAttributes)
				PreHook:     common.#Script & {
					Expr: """
						(() => {
							const attributes = context.data.\(table)

							const result = {
								id: each.node.id,
								input: {
									...each.node,
									...attributes.reduce((acc, attr) => {
										acc[attr] = null
										return acc
									}, {}),
								}
							}
							delete result.input.id
							return result
						})()
					"""
				}
				Operation: pipeline.#GraphqlOperation & {
					Query: """
					mutation update\(table)($id: ID!, $input: \(table)UpdateInput!) {
						update\(table)(id: $id, input: $input) {
							id
						}
					}"""
				}
				PostScript: """
				{
					"result": args.update\(table)
				}"""
			}
		},
		for table, plural in #tables {
			{
				Name:        "delete\(table)"
				Description: "Delete the \(table) records"
				Invoker:     settings.adminInvoker
				ForEach:     "context.pipeline.get\(table).items"
				Test:        "size(context.pipeline.get\(table).items) > 0" // skip if no records are found
				PreScript: """
					{
					    "id": each.node.id,
					}
					"""
				Operation: pipeline.#GraphqlOperation & {
					Query: """
                    mutation delete\(table)($id: ID!) {
                        delete\(table)(id: $id)
                    }"""
				}
				PostScript: """
                {
                    "result": args.delete\(table)
                }"""
			}
		},
	]
}
