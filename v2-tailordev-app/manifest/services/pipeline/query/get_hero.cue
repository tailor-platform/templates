package query

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

getHerosResponse: pipeline.#ResponseField & {
	type: pipeline.#Type & {
		name: "getHerosResponse"
		fields: [
			{name: "success", type: pipeline.Boolean},
			{
				name: "heros"
				type: pipeline.#Type & {
					name: "Hero"
					fields: [
						{name: "id", type:   pipeline.ID},
						{name: "name", type: pipeline.String},
					]
				}
				array: true
			},
		]
	}
	array:    false
	required: false
}

GetHeros: pipeline.#Resolver & {
	name:          "getHeros"
	description:   "query resolver for getting heros"
	authorization: "true"
	response:      getHerosResponse
	pipelines: [
		{
			name: "getCharacterHeros"
			operation: pipeline.#GraphqlOperation & {
				query: """
					query getCharacterHeros {
						characters(query: {
							roles: {ne: null}
						}) {
							collection {
								id
								name
							}
						}
					}
					"""
			}
			postScript: """
				{
					"success": true,
					"heros": args.characters.collection.map(c, {
						"id": c.id,
						"name": c.name
					})
				}
				"""
		},
	]
}
