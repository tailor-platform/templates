package timeline

import (
  "github.com/tailor-platform/tailorctl/schema/v2/executor"
  "github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
  "tailor.build/template/manifest/settings"
)

#purchaseOrderCreated: executor.#Executor & {
  Name: "timeline-purchase-order-created",
  Description: "Timeline event for purchaseOrder created",
  Trigger: executor.#TriggerEvent & {
    EventType: "tailordb.type_record.created"
    Condition: common.#Script & {
      Expr: """
            args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "PurchaseOrder"
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
              "sourceType": "PurchaseOrder",
              "sourceID": args.data.newRecord.id,
              "eventName": "purchase_order.created",
              "eventType": "activity",
              "objectType": "PurchaseOrder",
              "objectID": args.data.newRecord.id,
              "messageSegments": [
                {
                  "text": "PurchaseOrder created",
                  "type": "text"
                },
                {
                  "type": "date",
                  "dateValue": args.data.newRecord.createdAt
                }
              ]
            },
            {
              "sourceType": "PurchaseOrder",
              "sourceID": args.data.newRecord.id,
              "eventName": "purchaseOrder.created",
              "eventType": "correspondence",
              "objectType": "Supplier",
              "objectID": args.data.newRecord.supplierID,
              "messageSegments": [
                {
                  "text": "#PO",
                  "type": "link",
                  "linkedObjectType": "PurchaseOrder",
                  "linkedObjectID": args.data.newRecord.id

                },
                {
                  text: "submitted to the supplier",
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

#purchaseOrderConfirmed: executor.#Executor & {
  Name: "timeline-purchase-order-confirmed",
  Description: "Timeline event for purchaseOrder confirmed",
  Trigger: executor.#TriggerEvent & {
    EventType: "tailordb.type_record.updated"
    Condition: common.#Script & {
      Expr: """
            args.NamespaceName == "\(environment.#app.namespace)" && args.TypeName == "PurchaseOrder" && args.data.newRecord.status == "confirmed" && args.data.oldRecord.status != "confirmed"
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
              "sourceType": "PurchaseOrder",
              "sourceID": args.data.newRecord.id,
              "eventName": "purchase_order.confirmed",
              "eventType": "activity",
              "objectType": "PurchaseOrder",
              "objectID": args.data.newRecord.id,
              "messageSegments": [
                {
                  "text": "PurchaseOrder confirmed byt he supplier",
                  "type": "text"
                },
                {
                  "type": "date",
                  "dateValue": args.data.newRecord.createdAt
                }
              ]
            },
            {
              "sourceType": "PurchaseOrder",
              "sourceID": args.data.newRecord.id,
              "eventName": "purchaseOrder.confirmed",
              "eventType": "activity",
              "objectType": "Supplier",
              "objectID": args.data.newRecord.supplierID,
              "messageSegments": [
                {
                  "text": "#PO",
                  "type": "link",
                  "linkedObjectType": "PurchaseOrder",
                  "linkedObjectID": args.data.newRecord.id
                },
                {
                  text: "has been confirmed by the supplier",
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
