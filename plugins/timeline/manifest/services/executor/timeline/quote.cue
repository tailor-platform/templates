package timeline

import (
  "github.com/tailor-platform/tailorctl/schema/v2/executor"
  "github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
  "tailor.build/template/manifest/settings"
)

#quoteCreated: executor.#Executor & {
  Name: "timeline-quote-created",
  Description: "Timeline event for quote created",
  Trigger: executor.#TriggerEvent & {
    EventType: "tailordb.type_record.created"
    Condition: common.#Script & {
      Expr: """
            args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "Quote"
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
              "sourceID": args.data.newRecord.id,
              "eventName": "quote.created",
              "eventType": "activity",
              "objectType": "Quote",
              "objectID": args.data.newRecord.id,
              "messageSegments": [
                {
                  "text": "Quote created",
                  "type": "text"
                },
                {
                  "type": "date",
                  "dateValue": args.data.newRecord.createdAt
                }
              ]
            },
            {
              "sourceType": "Quote",
              "sourceID": args.data.newRecord.id,
              "eventName": "quote.created",
              "eventType": "activity",
              "objectType": "Supplier",
              "objectID": args.data.newRecord.supplierID,
              "messageSegments": [
                {
                  "text": "#Quote",
                  "type": "link",
                  "linkedObjectType": "Quote",
                  "linkedObjectID": args.data.newRecord.id

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
