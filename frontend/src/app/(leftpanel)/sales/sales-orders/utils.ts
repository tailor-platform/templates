import { gql } from "@fabrix-framework/fabrix";
import { Client } from "urql";
import { toast } from "sonner";
import CREATE_SHIPMENT_FROM_SALES_ORDER from "@/app/lib/IMS/createShipmentFromSalesOrder.gql";
import GET_SHIPMENT_LINE_ITEMS from "@/app/lib/IMS/getShipmentLineItems.gql";
import HOLD_SHIPMENT from "@/app/lib/IMS/holdShipment.gql";
import SHIP_SHIPMENT from "@/app/lib/IMS/shipShipment.gql";
import UPDATE_SALES_ORDER from "@/app/lib/IMS/updateSalesOrder.gql";
// import FULFILL_SHOPIFY_ORDER from "@/app/lib/IMS/fulfillShopifyOrder.gql";

const MUTATIONS = {
  CREATE_SHIPMENT: gql`
    ${CREATE_SHIPMENT_FROM_SALES_ORDER}
  `,
  HOLD_SHIPMENT: gql`
    ${HOLD_SHIPMENT}
  `,
  SHIP_SHIPMENT: gql`
    ${SHIP_SHIPMENT}
  `,
  GET_LINE_ITEMS: gql`
    ${GET_SHIPMENT_LINE_ITEMS}
  `,
  UPDATE_SALES_ORDER: gql`
    ${UPDATE_SALES_ORDER}
  `,
};

const pushVariantToShopify = async (variantId: string) => {
  /** hardcoded pipedream url for now — will be removed once we use a function service */
  await fetch("https://eooueqea9ac07t5.m.pipedream.net", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ variables: { variantID: variantId } }),
  });
};

const fulfillShopifyOrder = async (orderId: string) => {
  /** Update with your Pipedream workflow URL */
  await fetch("https://eoei4qahbz2vkzt.m.pipedream.net", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ orderId }),
  });
};

type ShipmentLineItem = {
  id: string;
  variantID: string;
  node: ShipmentLineItem;
};

type ShipmentEdge = {
  node: ShipmentLineItem;
};

const getShipmentLineItems = async (client: Client, shipmentId: string) => {
  const result = await client
    .query(MUTATIONS.GET_LINE_ITEMS, { shipmentID: shipmentId })
    .toPromise();

  return result.data.shipmentLineItems.edges.map(
    (edge: ShipmentEdge) => edge.node,
  );
};

export const handleShipmentCreation = async (
  client: Client,
  salesOrderId: string,
  shopifyOrderId: string | null,
  onSuccess?: () => void,
) => {
  const toastId = toast.loading("Processing shipment...", {
    richColors: true,
    description: "Creating new shipment",
    position: "top-center",
  });

  try {
    // Add debug logging
    console.log("Starting shipment creation with:", {
      salesOrderId,
      shopifyOrderId,
    });

    // Create shipment
    const shipmentResult = await client
      .mutation(MUTATIONS.CREATE_SHIPMENT, {
        salesOrderID: salesOrderId,
      })
      .toPromise();

    if (!shipmentResult.data?.createShipmentFromSalesOrder?.shipmentId) {
      throw new Error("Failed to create shipment - no shipment ID returned");
    }

    // Get line items
    toast.loading("Processing shipment...", {
      id: toastId,
      description: "Processing line items",
      position: "top-center",
    });

    const shipmentId =
      shipmentResult.data.createShipmentFromSalesOrder.shipmentId;
    const lineItems = await getShipmentLineItems(client, shipmentId);

    if (!lineItems?.length) {
      throw new Error("No line items returned from query");
    }

    // Process shipment
    toast.loading("Processing shipment...", {
      id: toastId,
      description: "Shipping items",
      position: "top-center",
    });

    const itemIds = lineItems.map((item: ShipmentLineItem) => item.id);
    await client
      .mutation(MUTATIONS.HOLD_SHIPMENT, {
        shipmentItemIDs: itemIds,
      })
      .toPromise();
    await client
      .mutation(MUTATIONS.SHIP_SHIPMENT, {
        shipmentItemIDs: itemIds,
      })
      .toPromise();

    // Push variants to Shopify
    toast.loading("Processing shipment...", {
      id: toastId,
      description: "Syncing with Shopify",
      position: "top-center",
    });

    const variantIds = lineItems.map(
      (item: ShipmentLineItem) => item.variantID,
    );
    await Promise.all(variantIds.map(pushVariantToShopify));

    // Update sales order status
    await client
      .mutation(MUTATIONS.UPDATE_SALES_ORDER, {
        id: salesOrderId,
        input: { shipStationOrderStatus: "shipped" },
      })
      .toPromise();

    // Fulfill Shopify order if ID exists
    if (shopifyOrderId) {
      console.log("Fulfilling Shopify order:", shopifyOrderId);
      toast.loading("Processing shipment...", {
        id: toastId,
        description: "Fulfilling Shopify order",
        position: "top-center",
      });

      await fulfillShopifyOrder(shopifyOrderId);
    } else {
      console.log("No Shopify ID found for order:", salesOrderId);
    }

    toast.success("Shipment processed successfully", {
      id: toastId,
      richColors: true,
      position: "top-center",
    });

    onSuccess?.();
    return true;
  } catch (error) {
    toast.error(
      error instanceof Error ? error.message : "Failed to process shipment",
      {
        id: toastId,
        richColors: true,
        position: "top-center",
      },
    );
    return false;
  }
};
