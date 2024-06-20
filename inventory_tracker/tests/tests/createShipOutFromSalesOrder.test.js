import { context } from "@tailor-platform/api-test-library";

/**
 * Test createShipOutFromSalesOrder
 * Creates ShipOut from the sales order
 * and checks if the ship out is created
*/
test("1. createShipOutFromSalesOrder", async () => {
    // get sales order
    const salesOrder = context.env.SalesOrder.salesOrder1;

    // create stock events from receipt line items
    await context.runPipeline("createShipOutFromSalesOrder", {
        input: {
            salesOrderID: salesOrder.id,
            shipOutDate: salesOrder.salesOrderDate
        }
    });

    // Fetch ship out created from sales order
    const shipOutAll = await context.fetchAll("ShipOut");
    const shipOut = shipOutAll.find(shipOutItem => shipOutItem.salesOrderID === salesOrder.id);

    // Add ship out to the context 
    context.addToEnv("ShipOut", shipOut.id, shipOut);
    
    expect(shipOut.quantity).toBe(shipOut.salesOrder.quantity);
    
    console.info("Ship out created from sales order");
}, 30000);  