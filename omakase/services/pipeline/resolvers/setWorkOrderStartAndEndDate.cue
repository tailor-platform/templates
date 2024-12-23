package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

setWorkOrderStartAndEndDate: pipeline.#Resolver & {
	Authorization: pipeline.#AuthInsecure
	Name:          "setWorkOrderStartAndEndDate"
	Description: """
		The purpose of this operation is to set the start and end dates for a specific Work Order. The steps involved are as follows:
		
		1. Fetch the details of the Work Order, including its associated Manufacturing Order (MO) and work center information.
		2. Fetch all operations and daily schedules associated with a specific work center to identify existing work orders.
		3. Retrieve all work orders associated with the specified operations and identify available scheduling slots based on the provided schedule date and duration.
		4. Update the start and end dates of the specified Work Order.
	"""
	Inputs: [
		{
			Name:     "input"
			Required: true
			Type: {
				Name: "SetWorkOrderStartAndEndDateInput"
				Fields: [
					{Name: "workOrderId", Type: pipeline.ID, Required: true},
					{Name: "scheduleDateTime", Type: pipeline.DateTime, Required: true},
					{Name: "bookDuration", Type: pipeline.Int, Required: true},
				]
			}
		},
	]
	Response: {
		Type: {
			Name: "SetWorkOrderStartAndEndDateOutput"
			Fields: [
				{Name: "startDateTime", Type: pipeline.DateTime},
				{Name: "endDateTime", Type: pipeline.DateTime},
			]
		}
	}
	PostScript: """
	{
		"startDateTime": get(context.pipeline.getExistingWorkOrdersByOperations.startDate),
		"endDateTime": get(context.pipeline.getExistingWorkOrdersByOperations.endDate),
	}"""
	Pipelines: [
		{
			Name:        "getWorkOrder"
			Description: " Fetches the details of a Work Order, including its associated Manufacturing Order (MO) and work center information.",
			PreScript: """
				{
					'workOrderId': context.args.input.workOrderId,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query getWorkOrder($workOrderId: ID!) {
						workOrder(id:$workOrderId) {
							operation {
								id
								workCenter {
									id
									workingHours {
										id
									}
								}
							}
						}
					}"""
			}
			PostScript: """
				{
					"workOrder": args.workOrder,
				}"""
			PostValidation: """
					isNull(context.pipeline.getWorkOrder.workOrder) ?
					['No work order found for ',context.args.input.workOrderId].join(''):
					''
				"""
		},
		{
			Name:        "getAllExistingOperationBelongsToWorkcenter"
			Description: "Fetches all operations and daily schedules associated with a specific work center to identify existing work orders",
			Test: 		 "!isNull(context.pipeline.getWorkOrder.workOrder)"
			PreScript: """
				{
					'workCenterId': context.pipeline.getWorkOrder.workOrder.operation.workCenter.id,
					'workingHourId': context.pipeline.getWorkOrder.workOrder.operation.workCenter.workingHours.id,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query getAllExistingOperationBelongsToWorkcenter($workCenterId: ID!, $workingHourId: ID!) {
						operations(query: {workCenterId: {eq: $workCenterId}}) {
							collection {
								id
							}
						}

						dailySchedules(query: {workingHoursId: {eq: $workingHourId}}) {
							collection {
								workFrom
								workTo
								id
								dayOfWeek
							}
						}

						aggregateDailySchedules(query: {workingHoursId: {eq: $workingHourId}}) {
							sum {
								duration
							}
						}
					}"""
			}
			PostScript: """
				{
					"operations": args.operations,
					"dailySchedules": args.dailySchedules,
					"aggregateDailySchedules": args.aggregateDailySchedules,
				}"""
			PostValidation: """
					size(context.pipeline.getAllExistingOperationBelongsToWorkcenter.operations.collection) <= 0 ?
					['No work operations found for ',context.args.input.workOrderId].join(''):
					''
				"""
		},
		{
			Name:        "getExistingWorkOrdersByOperations"
			Description: "Retrieves all work orders associated with specified operations and identifies available scheduling slots based on the provided schedule date and duration."
			Test: 		 "size(context.pipeline.getAllExistingOperationBelongsToWorkcenter.operations.collection) > 0"
			PreScript: """
				{
					'operationsId': size(context.pipeline.getAllExistingOperationBelongsToWorkcenter.operations.collection) > 0? context.pipeline.getAllExistingOperationBelongsToWorkcenter.operations.collection.map(e, e.id):[],
					'scheduleDateTime': context.args.input.scheduleDateTime,
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					query getExistingWorkOrdersByOperations($operationsId: [ID],$scheduleDateTime:DateTime) {
						workOrders(query: {operationId: {in: $operationsId}, isDeleted: {eq: false}, startDate: {gte: $scheduleDateTime}}) {
							collection {
								id
								startDate
								endDate
								operation {
									workCenter {
										id
									}
								}
							}
						}
					}"""
			}
			PostHook: common.#Script & {
				Expr: """
				(() => {
					const { collection: orders } = args.workOrders;
					const { collection: dailySchedules } = context.pipeline.getAllExistingOperationBelongsToWorkcenter.dailySchedules;
					const { scheduleDateTime,bookDuration } = context.args.input;
					const workCenterId = context.pipeline.getWorkOrder.workOrder.operation.workCenter.id;

					const sameWorkCenterOrders = orders.filter((ord) => ord.operation.workCenter.id === workCenterId);

					const daysOfWeekMap = {
						0: "Sunday",
						1: "Monday",
						2: "Tuesday",
						3: "Wednesday",
						4: "Thursday",
						5: "Friday",
						6: "Saturday"
					};

					function parseTime(timeStr) {
						const [hours, minutes] = timeStr.split(":").map(Number);
						return { hours, minutes };
					};

					function getNextAvailableSlot(startDateStr, totalDuration) {
						let startDate = new Date(startDateStr);
						if (isNaN(startDate)) {
							throw new Error("Invalid startDate");
						}

						let remainingDuration = totalDuration; // totalDuration is in minutes
						let daysChecked = 0; // Initialize the counter for days checked
						const maxDaysToCheck = 100; // Set the limit to 100 days

						while (daysChecked < maxDaysToCheck) { // Check up to 100 days
							const dayOfWeek = daysOfWeekMap[startDate.getUTCDay()];
							const workingDay = dailySchedules.find(day => day.dayOfWeek === dayOfWeek);

							if (workingDay) {
								const workFrom = parseTime(workingDay.workFrom);
								const workTo = parseTime(workingDay.workTo);
								let currentWorkStart = new Date(startDate);
								currentWorkStart.setUTCHours(workFrom.hours, workFrom.minutes, 0, 0);
								let currentWorkEnd = new Date(startDate);
								currentWorkEnd.setUTCHours(workTo.hours, workTo.minutes, 0, 0);

								// Adjust startDate if it's before the working hours
								if (startDate < currentWorkStart) {
									startDate = currentWorkStart;
								}

								let availableStartTime = startDate;

								// Sort existing slots by start time
								const sortedSlots = sameWorkCenterOrders
									.map(slot => ({
										start: new Date(slot.startDate),
										end: new Date(slot.endDate)
									}))
									.sort((a, b) => a.start - b.start);

								for (const slot of sortedSlots) {
									// Check if there's enough time before the next booked slot
									if (availableStartTime < slot.start) {
										const availableMinutes = (slot.start.getTime() - availableStartTime.getTime()) / 60000; // Convert to minutes
										if (remainingDuration <= availableMinutes) {
											const endDate = new Date(availableStartTime);
											endDate.setUTCMinutes(availableStartTime.getUTCMinutes() + remainingDuration);
											return { startDate: availableStartTime.toISOString(), endDate: endDate.toISOString() };
										}
									}

									// Move available start time to the end of the booked slot if it's within working hours
									if (availableStartTime < slot.end) {
										availableStartTime = slot.end;
									}
								}

								// Check time left after the last booked slot on the current working day
								if (availableStartTime < currentWorkEnd) {
									const availableMinutes = (currentWorkEnd.getTime() - availableStartTime.getTime()) / 60000; // Convert to minutes
									if (remainingDuration <= availableMinutes) {
										const endDate = new Date(availableStartTime);
										endDate.setUTCMinutes(availableStartTime.getUTCMinutes() + remainingDuration);
										return { startDate: availableStartTime.toISOString(), endDate: endDate.toISOString() };
									}
								}
							}

							// Move to the next day
							startDate.setUTCDate(startDate.getUTCDate() + 1);
							startDate.setUTCHours(0, 0, 0, 0);
							daysChecked++; // Increment the counter for each day checked
						}

						// If no available slot is found within 100 days, throw an error
						throw new Error("No available slot found within the next 100 days.");
					}

					const availableDuration = getNextAvailableSlot(scheduleDateTime, bookDuration)

					return {
						startDate: availableDuration.startDate,
						endDate: availableDuration.endDate,
						sameWorkCenterOrders,
					};
				})()
				"""
			}
		},
		{
			Name:        "updateWorkOrderStartAndEndDate"
			Description: "Updates the start and end dates of a specified work order."
			PreScript: """
				{
					"workOrderId": context.args.input.workOrderId,
					"input": {
						"startDate": get(context.pipeline.getExistingWorkOrdersByOperations.startDate),
						"endDate": get(context.pipeline.getExistingWorkOrdersByOperations.endDate),
						"status":"Waiting_for_components"
					}
				}"""
			Operation: pipeline.#GraphqlOperation & {
				Query: """
					mutation updateWorkOrderStartAndEndDate($workOrderId:ID!,$input:WorkOrderUpdateInput) {
						updateWorkOrder(id: $workOrderId, input: $input) {
							id
							startDate
							endDate
						}
					}
					"""
			}
		},
	]
}
