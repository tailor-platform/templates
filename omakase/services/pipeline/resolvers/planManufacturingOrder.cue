package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

planManufacturingOrder: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "planManufacturingOrder"
	Description: """
		The purpose of this operation is to plan a Manufacturing Order (MO) and its associated Work Orders. The steps involved are as follows:
		
		1. Fetch the details of the MO along with its associated active Work Orders.
		2. Fetch the dependent work orders and sort it by dependency workorders, and will throw error if cyclic dependency found.
		3. Create variable to store all work orders startDateTime and endDateTime.
		4. Set the start and end dates for each Work Order based on the provided schedule and expected duration.
		5. Update the MO's plan flag to indicate that a plan has been created, along with the scheduled date and time.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "PlanManufacturingOrderInput"
				Fields: [
					{Name: "manufacturingOrderId", Type: pipeline.ID, Required: true},
					{Name: "scheduleDateTime", Type: pipeline.String, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "PlanManufacturingOrderOutput"
			Fields: [
				{Name: "success", Type: pipeline.Boolean},
				{Name: "startDateTime", Type: pipeline.DateTime},
				{Name: "endDateTime", Type: pipeline.DateTime},
			]
		}
	}
	PostScript: """
	{
		"success": true,
		"startDateTime": context.pipeline.updateMOPlanFlag.startDateTime,
		"endDateTime": context.pipeline.updateMOPlanFlag.endDateTime,
	}"""
	Pipelines: [
		{
			Name:        "getAllWorkOrdersOfMO"
			Description: "Fetches the details of a Manufacturing Order (MO) along with its associated active Work Orders.",
			PreScript: """
				{
					'manufacturingOrderId': context.args.input.manufacturingOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query getAllWorkOrdersOfMO($manufacturingOrderId: ID!) {
						manufacturingOrder(id: $manufacturingOrderId) {
							quantity
							id
						}
						
						workOrders(query: {moId: {eq: $manufacturingOrderId}, isDeleted: {eq: false}}) {
							collection {
								id
								order
								expectedDuration
							}
						}
					}"""
			}
			PostScript: """
				{
					"manufacturingOrder": args.manufacturingOrder,
					"workOrders": args.workOrders,
				}"""
			PostValidation: """
				isNull(context.pipeline.getAllWorkOrdersOfMO.manufacturingOrder) ?
				['No manufacturing order found for the given ID: ', context.args.input.manufacturingOrderId].join('') :
				size(context.pipeline.getAllWorkOrdersOfMO.workOrders) == 0 ?
				['No work orders found for given ID: ', context.args.input.manufacturingOrderId].join('') :
				''
			"""
		},
		{
			Name:        "getAllDependentWorkOrders"
			Description: "Retrieve all dependent work orders."
			Test: 		 "size(context.pipeline.getAllWorkOrdersOfMO.workOrders.collection) > 0"
			PreScript: """
			{
					"workOrderId": size(context.pipeline.getAllWorkOrdersOfMO.workOrders.collection)== 0 ? [] : context.pipeline.getAllWorkOrdersOfMO.workOrders.collection.map(e, e.id),
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				query getAllDependentWorkOrders($workOrderId:[ID]) {
					workOrderDependencies(query: {workOrderId: {in: $workOrderId}}) {
						collection {
							dependsOnWorkOrderId
							workOrderId
							id
						}
					}
				}
				"""
			}
			PostHook: common.#Script & {
				Expr: """
					(() => {
						const workOrders = context.pipeline.getAllWorkOrdersOfMO.workOrders.collection
						const dependenciesWorkOrders = args.workOrderDependencies.collection
						
						function sortWorkOrders(workOrders, dependencies) {
							try {
								// Create a map to easily access work orders by their id
								const workOrderMap = new Map();
								workOrders.forEach(wo => workOrderMap.set(wo.id, wo));

								// Create an adjacency list (graph) for dependencies
								const dependencyGraph = {};
								dependencies.forEach(dep => {
									if (!dependencyGraph[dep.workOrderId]) {
										dependencyGraph[dep.workOrderId] = [];
									}
									dependencyGraph[dep.workOrderId].push(dep.dependsOnWorkOrderId);
								});

								// Visited set to track work orders
								const visited = new Set();
								const sorted = [];
								const visiting = new Set();

								// Recursive function to perform a topological sort
								function visit(workOrderId) {
									// If this work order is being visited, there is a cyclic dependency
									if (visiting.has(workOrderId)) {
										throw new Error("Cyclic dependency detected.");
									}

									// If already visited, skip it
									if (visited.has(workOrderId)) {
										return;
									}

									// Mark as visiting
									visiting.add(workOrderId);

									// Visit dependencies (if any)
									if (dependencyGraph[workOrderId]) {
										dependencyGraph[workOrderId].forEach(dependencyId => {
											visit(dependencyId);
										});
									}

									// Mark as visited and add to sorted list
									visiting.delete(workOrderId);
									visited.add(workOrderId);
									sorted.push(workOrderMap.get(workOrderId));
								}

								// Perform topological sort for all work orders
								workOrders.forEach(workOrder => {
									if (!visited.has(workOrder.id)) {
										visit(workOrder.id);
									}
								});

								// If sorting is successful, return the sorted array and status true
								return {
									sortedArray: sorted,
									status: true
								};
							} catch (error) {
								// In case of a cyclic dependency, return an empty array and status false
								return {
									sortedArray: [],
									status: false
								};
							}
						}

						const result = sortWorkOrders(workOrders, dependenciesWorkOrders)

						return {
							"sortedWorkOrders":result.sortedArray,
							"status":result.status,
							dependenciesWorkOrders
						}
					})()
				"""
			}
			PostValidation: """
				!context.pipeline.getAllDependentWorkOrders.status ? 'Cyclic dependency found in operations' : ''
			"""
		},
		{
			Name:        "workOrderStartAndEndDateTimeVariable"
 			Description: "Sets the start and end dates for each Work Order based on the provided schedule and expected duration.",
			PostHook: common.#Script & {
				Expr: """
					(() => {
						return {
							"workOrderStartAndEndDateTime": [],
						}
					})()
				"""
			}
			
		},
		{
			Name:        "setWorkOrderStartAndEndDate"
			Description: "Sets the start and end dates for each Work Order based on the provided schedule and expected duration.",
			ForEach:	 "context.pipeline.getAllDependentWorkOrders.sortedWorkOrders"
			Test: 		 "size(context.pipeline.getAllDependentWorkOrders.sortedWorkOrders) > 0"
			PreHook: common.#Script & {
				Expr: """
				(() => {
					const preferredDateTime = context.args.input.scheduleDateTime;
					const dependenciesWorkOrders = context.pipeline.getAllDependentWorkOrders.dependenciesWorkOrders;
					const workOrderStartAndEndDateTime = context.pipeline.workOrderStartAndEndDateTimeVariable.workOrderStartAndEndDateTime

					// Function to get the biggest endDateTime for a given workOrderId
					function getBiggestEndDateTime(workOrderId) {

						if (workOrderStartAndEndDateTime.length === 0) {
							return new Date(preferredDateTime).toISOString();
						}

						// Find all dependencies for the given workOrderId
						const dependencies = dependenciesWorkOrders
							.filter(dependency => dependency.workOrderId === workOrderId)
							.map(dependency => dependency.dependsOnWorkOrderId);

						if (dependencies.length === 0) {
							return new Date(preferredDateTime).toISOString();
						}

						// Map to find endDateTimes for the dependent work orders
						const endDateTimes = dependencies.map(depId => {
							const workOrder = workOrderStartAndEndDateTime.find(
							order => order.workOrderId === depId
							);
							return workOrder ? new Date(workOrder.endDateTime) : null;
						}).filter(date => date !== null); // Filter out any null values

						// Find the biggest endDateTime
						if (endDateTimes.length === 0) {
							return null; // No valid endDateTimes found
						}

						return new Date(Math.max(...endDateTimes)).toISOString(); // Return the max date in ISO format
					}

					const biggestEndDateTime = getBiggestEndDateTime(each.id);

					return {
						"input": {
							"bookDuration": each.expectedDuration,
							"workOrderId": each.id,
							"scheduleDateTime": biggestEndDateTime
						}
					};
				})()
				"""
			}
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation setWorkOrderStartAndEndDate($input: SetWorkOrderStartAndEndDateInput!) {
					setWorkOrderStartAndEndDate(
						input: $input
					) {
						startDateTime
    					endDateTime
					}
				}"""
			}
			PostHook: common.#Script & {
				Expr: """
					(() => {

						const originalValue = context.pipeline.workOrderStartAndEndDateTimeVariable.workOrderStartAndEndDateTime;

						const response = {
							"workOrderId": each.id,
							"startDateTime": args.setWorkOrderStartAndEndDate.startDateTime,
							"endDateTime": args.setWorkOrderStartAndEndDate.endDateTime,
						}

						originalValue.push(response)
						context.pipeline.workOrderStartAndEndDateTimeVariable.workOrderStartAndEndDateTime = originalValue
						return response
					})()
				"""
			}
		},
		{
			Name:        "updateStatusOfDependentWorkOrder"
			Description: "Set dependent work order status to waiting for other component.",
			ForEach:	 "context.pipeline.getAllDependentWorkOrders.dependenciesWorkOrders"
			Test: 		 "size(context.pipeline.getAllDependentWorkOrders.dependenciesWorkOrders) > 0"
			PreScript: """
			{
				"input": {
					"status": "Waiting_for_another_WO",
				},
				"id":each.workOrderId
			}
			"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation updateStatusOfDependentWorkOrder($id:ID!,$input:WorkOrderUpdateInput) {
					updateWorkOrder(id: $id, input: $input) {
						id
						status
					}
				}"""
			}
		},
		{
			Name:        "updateMOPlanFlag"
			Description: "Updates the Manufacturing Order (MO) plan flag to indicate that a plan has been created, along with the scheduled date and time"
			PreHook: common.#Script & {
				Expr: """
				(() => {
					const data = context.pipeline.setWorkOrderStartAndEndDate;

					// Convert strings to Date objects
					const dateTimes = data.map(e => ({
						startDateTime: new Date(e.startDateTime),
						endDateTime: new Date(e.endDateTime)
					}));

					// Calculate min and max dateTimes
					const minDateTime = new Date(Math.min(...dateTimes.map(e => e.startDateTime)));
					const maxDateTime = new Date(Math.max(...dateTimes.map(e => e.endDateTime)));

					return {
						'id': context.args.input.manufacturingOrderId,
						'input': {
							'isPlanCreated':true,
							'startDateTime':minDateTime.toISOString(),
							'endDateTime':maxDateTime.toISOString(),
							'status':'Planned'
						}
					};
				})()
				"""
			}
			Operation: pipeline.#GraphqlOperation & {
				Query: """
				mutation updateMOPlanFlag($input: ManufacturingOrderUpdateInput!, $id: ID!) {
					updateManufacturingOrder(id: $id, input: $input) {
						id
						startDateTime
						endDateTime
					}
				}
				"""
			}
			PostScript: """
					{
						"manufacturingOrderId": context.args.input.manufacturingOrderId,
						"startDateTime": args.updateManufacturingOrder.startDateTime,
						"endDateTime": args.updateManufacturingOrder.endDateTime,
						"success": true,
					}"""
		}
	]
}
