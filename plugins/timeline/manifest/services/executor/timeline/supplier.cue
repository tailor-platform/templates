package timeline

import (
  "github.com/tailor-platform/tailorctl/schema/v2/executor"
  "github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
  "tailor.build/template/manifest/settings"
)

#supplierCreated: executor.#Executor & {
  Name: "timeline-supplier-created",
  Description: "Timeline event for supplier created",
  Trigger: executor.#TriggerEvent & {
    EventType: "tailordb.type_record.created"
    Condition: common.#Script & {
      Expr: """
            args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "Supplier"
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
              "sourceType": "Supplier",
              "sourceID": args.data.newRecord.id,
              "eventName": "supplier.created",
              "eventType": "changelog",
              "objectType": "Supplier",
              "objectID": args.data.newRecord.id,
              "messageSegments": [
                {
                  "text": "Supplier account created",
                  "type": "text"
                },
                {
                  "type": "date",
                  "dateValue": args.data.newRecord.createdAt
                }
              ]
            }
          ]
        }
      """
      }
  }
}

#requestForQuoteAssigned: executor.#Executor & {
  Name: "timeline-supplier-rfq-assigned",
  Description: "Timeline event for supplier assigned to RFQ",
  Trigger: executor.#TriggerEvent & {
    EventType: "tailordb.type_record.created"
    Condition: common.#Script & {
      Expr: """
            args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "RequestForQuoteSupplier"
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
              "sourceType": "RequestForQuoteSupplier",
              "sourceID": args.data.newRecord.id,
              "eventName": "request_for_quote.supplier_invited",
              "eventType": "activity",
              "objectType": "Supplier",
              "objectID": args.data.newRecord.supplierID,
              "messageSegments": [
                {
                  "text": "#RFQ",
                  "type": "link",
                  "linkedObjectType": "RequestForQuote",
                  "linkedObjectID": args.data.newRecord.requestForQuoteID
                },
                {
                  text: "assigned to supplier ",
                  type: "text"
                }
              ]
            }
          ]
        }
      """
      }
  }
}
