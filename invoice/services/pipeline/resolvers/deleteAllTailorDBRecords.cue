package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"tailor.build/template/settings:settings"
)

// Here add the table name and its plural form
#tables: {
	Invoice: "invoices"
	Role:    "roles"
	User:    "users"
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
                        \(plural)(size: 100000){
                            collection{
                                id
                            }
                        }
                    }"""
				}
				PostScript: """
                {
                    "items": args.\(plural).collection
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
					    "id": each.id,
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
