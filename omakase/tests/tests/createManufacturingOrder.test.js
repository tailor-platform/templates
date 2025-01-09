import { context } from "@tailor-platform/api-test-library";

/**
 * Test for successful creation of a Manufacturing Order
 * Checks if the pipeline returns a valid UUID for the manufacturing order
*/
test("1. Successful Creation of Manufacturing Order", async () => {
	const bomId = context.env.Bom.bom25.id;
	const quantity = 2;
	const name = 'Bike';

	console.log("Input Values:", { bomId, quantity, name });

	try {
		// Run the pipeline to create manufacturing order and work orders
		const result = await context.runPipeline("createManufacturingOrderAndWorkOrders", {
			input: { bomId, quantity, name }
		});

		console.log("Pipeline Result:", result);

		// Validate that the result contains a manufacturingOrderId
		expect(result.manufacturingOrderId).toBeDefined();
		console.info("Manufacturing order created successfully with ID:", result.manufacturingOrderId);

		const [manufacturingOrder, workOrders = [], moLineItems] = await Promise.all([
			context.fetch("ManufacturingOrder", result.manufacturingOrderId),
			context.fetchAll("WorkOrder", { moId: { eq: result.manufacturingOrderId } }),
			context.fetchAll("MOLineItem", { moId: { eq: result.manufacturingOrderId } }),
		]);
		const woDependencies = await context.fetchAll("WorkOrderDependency", { workOrderId: { in: workOrders.map(wo => wo.id) } });

		context.addToEnv("ManufacturingOrder", manufacturingOrder.id, manufacturingOrder);
		workOrders.forEach((workOrder) => context.addToEnv("WorkOrder", workOrder.id, workOrder));
		moLineItems.forEach((moLineItem) => context.addToEnv("MOLineItem", moLineItem.id, moLineItem));
		woDependencies.forEach((woDependency) => context.addToEnv("WorkOrderDependency", woDependency.id, woDependency));
	} catch (error) {
		console.error("Error running pipeline:", error);
		throw error;  // Re-throw the error to fail the test
	}
}, 60000);

/**
 * Test for handling non-existent BOM ID
 * Verifies that an error is thrown when an invalid BOM ID is provided
 */
test("2. Handling Non-Existent BOM ID", async () => {
	// Define input for the pipeline with an invalid BOM ID
	const bomId = context.env.Uom.uom2.id; // This BOM ID does not exist
	const quantity = 2;
	const name = 'Test Wheel';

	try {
		// Attempt to run the pipeline with the invalid BOM ID
		await context.runPipeline("createManufacturingOrderAndWorkOrders", {
			input: {
				bomId,
				quantity,
				name
			}
		});
		// If no error is thrown, fail the test
		fail("Expected an error to be thrown for non-existent BOM ID");
	} catch (error) {
		// Validate that the error message is as expected
		expect(error.message).toContain(`No BOM found for the given BOM ID: ${bomId}`);
		console.info("Error handling works as expected:", error.message);
	}
}, 60000);

/**
 * Test for handling the case where no active operations are found
 * Verifies that an error is thrown when the provided BOM ID has no active operations
 */
test("3. No Active Operations Found for Given BOM ID", async () => {
	// Define input for the pipeline with a valid BOM ID that has no active operations
	const bomId = context.env.Bom.bom3.id; // bom2 is wheel
	const quantity = 2;
	const name = 'Tube';

	try {
		// Attempt to run the pipeline with the BOM ID that has no active operations
		await context.runPipeline("createManufacturingOrderAndWorkOrders", {
			input: {
				bomId,
				quantity,
				name
			}
		});
		// If no error is thrown, fail the test
		fail("Expected an error to be thrown for BOM ID with no active operations");
	} catch (error) {
		// Validate that the error message is as expected
		expect(error.message).toContain(`No operations found for the BOM ID: ${bomId}`);

		console.info("Error handling works as expected:", error.message);
	}
}, 60000);
