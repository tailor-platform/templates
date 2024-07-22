package timeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
	"tailor.build/template/settings"
)

#quoteCreated: executor.#Executor & {
	Name:        "timeline-quote-created"
	Description: "Timeline event for quote created"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
            args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "Quote"
            """
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Invoker: settings.adminInvoker
		Query: """
			  mutation createTimelineEntry(
			    $input: [TimelineEntryCreateInput]!
			  ) {
			    bulkUpsertTimelineEntries(input: $input)
			  }
			"""
		Variables: common.#Script & {
			Expr: """
				  data = {
				    "input": [
				      {
				        "sourceType": "Quote",
				        "sourceID": args.newRecord.id,
				        "eventName": "quote.created",
				        "eventType": "activity",
				        "objectType": "Quote",
				        "objectID": args.newRecord.id,
				        "messageSegments": [
				          {
				            "text": "Quote created",
				            "type": "text"
				          },
				          {
				            "type": "date",
				            "dateValue": args.newRecord.createdAt
				          }
				        ]
				      },
				      {
				        "sourceType": "Quote",
				        "sourceID": args.newRecord.id,
				        "eventName": "quote.created",
				        "eventType": "activity",
				        "objectType": "Supplier",
				        "objectID": args.newRecord.supplierID,
				        "messageSegments": [
				          {
				            "text": "#Quote",
				            "type": "link",
				            "linkedObjectType": "Quote",
				            "linkedObjectID": args.newRecord.id

				          },
				          {
				            text: "submitted by the supplier",
				            type: "text"
				          }
				        ]
				      },
				    ]
				  }
				"""
		}
	}
}
