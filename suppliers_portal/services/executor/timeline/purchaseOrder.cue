package timeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
	"tailor.build/template/settings"
)

#purchaseOrderCreated: executor.#Executor & {
	Name:        "timeline-purchase-order-created"
	Description: "Timeline event for purchaseOrder created"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
            args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "PurchaseOrder"
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
				        "sourceID": args.newRecord.id,
				        "eventName": "purchase_order.created",
				        "eventType": "activity",
				        "objectType": "PurchaseOrder",
				        "objectID": args.newRecord.id,
				        "messageSegments": [
				          {
				            "text": "PurchaseOrder created",
				            "type": "text"
				          },
				          {
				            "type": "date",
				            "dateValue": args.newRecord.createdAt
				          }
				        ]
				      },
				      {
				        "sourceType": "PurchaseOrder",
				        "sourceID": args.newRecord.id,
				        "eventName": "purchaseOrder.created",
				        "eventType": "correspondence",
				        "objectType": "Supplier",
				        "objectID": args.newRecord.supplierID,
				        "messageSegments": [
				          {
				            "text": "#PO",
				            "type": "link",
				            "linkedObjectType": "PurchaseOrder",
				            "linkedObjectID": args.newRecord.id

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
	Name:        "timeline-purchase-order-confirmed"
	Description: "Timeline event for purchaseOrder confirmed"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.updated"
		Condition: common.#Script & {
			Expr: """
            args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "PurchaseOrder" && args.newRecord.status == "confirmed" && args.oldRecord.status != "confirmed"
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
				        "sourceID": args.newRecord.id,
				        "eventName": "purchase_order.confirmed",
				        "eventType": "activity",
				        "objectType": "PurchaseOrder",
				        "objectID": args.newRecord.id,
				        "messageSegments": [
				          {
				            "text": "PurchaseOrder confirmed by the supplier",
				            "type": "text"
				          },
				          {
				            "type": "date",
				            "dateValue": args.newRecord.createdAt
				          }
				        ]
				      },
				      {
				        "sourceType": "PurchaseOrder",
				        "sourceID": args.newRecord.id,
				        "eventName": "purchaseOrder.confirmed",
				        "eventType": "activity",
				        "objectType": "Supplier",
				        "objectID": args.newRecord.supplierID,
				        "messageSegments": [
				          {
				            "text": "#PO",
				            "type": "link",
				            "linkedObjectType": "PurchaseOrder",
				            "linkedObjectID": args.newRecord.id
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
