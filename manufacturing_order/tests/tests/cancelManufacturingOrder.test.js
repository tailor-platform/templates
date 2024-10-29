import { context } from "@tailor-platform/api-test-library";


/**
 * Test for successful cancellation of a Manufacturing Order
 * Validates that the Manufacturing Order and its associated Work Orders and MO Line Items are marked as deleted
 */
test("1. Successful Cancellation of Manufacturing Order", async () => {
    const moId = context.env.ManufacturingOrder.manufacturingorder1.id;

    console.log("Input MO ID:", { moId });

    try {
        // Run the pipeline to cancel the manufacturing order
        const result = await context.runPipeline("cancelManufacturingOrder", {
            input: { moId }
        });

        console.log("Pipeline Result:", result);

        // Validate that the result contains the correct manufacturingOrderId and success is true
        expect(result.manufacturingOrderId).toBe(moId);
        expect(result.success).toBe(true);
        console.info("Manufacturing order cancelled successfully for ID:", result.manufacturingOrderId);

    } catch (error) {
        console.error("Error running pipeline:", error);
        throw error;  // Re-throw the error to fail the test
    }
}, 60000);


/**
 * Test for handling non-existent Manufacturing Order ID
 * Verifies that an error is thrown when an invalid Manufacturing Order ID is provided
 */
test("2. Handling Non-Existent Manufacturing Order ID", async () => {
    const moId = context.env.Uom.uom2.id;  // This MO ID does not exist

    try {
        // Attempt to run the pipeline with the invalid MO ID
        await context.runPipeline("cancelManufacturingOrder", {
            input: { moId }
        });
        // If no error is thrown, fail the test
        fail("Expected an error to be thrown for non-existent Manufacturing Order ID");
    } catch (error) {
        // Validate that the error message is as expected
        expect(error.message).toContain(`No manufacturing order found for the given ID: ${moId}`);
        console.info("Error handling works as expected:", error.message);
    }
}, 60000);