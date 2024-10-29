package timeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
	"tailor.build/template/settings"
)

#supplierCreated: executor.#Executor & {
	Name:        "timeline-supplier-created"
	Description: "Timeline event for supplier created"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
            args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "Supplier"
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
				        "sourceID": args.newRecord.id,
				        "eventName": "supplier.created",
				        "eventType": "changelog",
				        "objectType": "Supplier",
				        "objectID": args.newRecord.id,
				        "messageSegments": [
				          {
				            "text": "Supplier account created",
				            "type": "text"
				          },
				          {
				            "type": "date",
				            "dateValue": args.newRecord.createdAt
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
	Name:        "timeline-supplier-rfq-assigned"
	Description: "Timeline event for supplier assigned to RFQ"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
            args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "RequestForQuoteSupplier"
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
				        "sourceID": args.newRecord.id,
				        "eventName": "request_for_quote.supplier_invited",
				        "eventType": "activity",
				        "objectType": "Supplier",
				        "objectID": args.newRecord.supplierID,
				        "messageSegments": [
				          {
				            "text": "#RFQ",
				            "type": "link",
				            "linkedObjectType": "RequestForQuote",
				            "linkedObjectID": args.newRecord.requestForQuoteID
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
