package executor

import (
	"github.com/tailor-platform/tailorctl/schema/v2/executor"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"tailor.build/template/environment"
)

executor.#Spec & {
	Executors: [
		#wOTimeTrackingCreated,
		#wOTimeTrackingUpdated,
		#wOTimeTrackingDeleted,
		#wOStatusUpdatedBlocked,
	]
}

#wOTimeTrackingCreated: executor.#Executor & {
	Name:        "wo-time-tracker-created"
	Description: "Update real duration on work log created"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.created"
		Condition: common.#Script & {
			Expr: """
				args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "WOTimeTracking"
				"""
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Query: """
			mutation ($input: ComputeWorkOrderCostRealDurationInput!) {
				computeWorkOrderCostRealDuration(
					input: $input
				) {
					totalDuration
				}
			}
			"""
		Variables: common.#Script & {
			Expr: """
				({
					"input": {
						"workOrderId": args.newRecord.workOrderId,
					},
					"arguments":args,
				})
				"""
		}
	}
}

#wOTimeTrackingUpdated: executor.#Executor & {
	Name:        "wo-time-tracker-updated"
	Description: "Update real duration on work log updated"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.updated"
		Condition: common.#Script & {
			Expr: """
				args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "WOTimeTracking"
				"""
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Query: """
			mutation ($input: ComputeWorkOrderCostRealDurationInput!) {
				computeWorkOrderCostRealDuration(
					input: $input
				) {
					totalDuration
				}
			}
			"""
		Variables: common.#Script & {
			Expr: """
				({
					"input": {
						"workOrderId": args.newRecord.workOrderId,
					},
					"arguments":args,
				})
				"""
		}
	}
}

#wOTimeTrackingDeleted: executor.#Executor & {
	Name:        "wo-time-tracker-deleted"
	Description: "Update real duration on work log deleted"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.deleted"
		Condition: common.#Script & {
			Expr: """
				args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "WOTimeTracking"
				"""
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Query: """
			mutation ($input: ComputeWorkOrderCostRealDurationInput!) {
				computeWorkOrderCostRealDuration(
					input: $input
				) {
					totalDuration
				}
			}
			"""
		Variables: common.#Script & {
			Expr: """
				({
					"input": {
						"workOrderId": args.oldRecord.workOrderId,
					},
					"arguments":args,
				})
				"""
		}
	}
}


#wOStatusUpdatedBlocked: executor.#Executor & {
	Name:        "wo-status-updated-blocked"
	Description: "update manufacturing order component status when work status gets blocked"
	Trigger: executor.#TriggerEvent & {
		EventType: "tailordb.type_record.updated"
		Condition: common.#Script & {
			Expr: """
				args.namespaceName == "\(environment.#app.namespace)" && args.typeName == "WorkOrder" && args.newRecord.status == "Blocked"
				"""
		}
	}
	Target: executor.#TargetTailorGraphql & {
		AppName: environment.#app.namespace
		Query: """
			mutation ($id: ID!, $input: ManufacturingOrderUpdateInput!) {
				updateManufacturingOrder(
					id: $id
					input: $input
				) {
					id
					status
				}
			}
			"""
		Variables: common.#Script & {
			Expr: """
				({
					"input": {
						"componentsStatus": "Blocked"
					},
					"id":args.newRecord.moId
				})
				"""
		}
	}
}