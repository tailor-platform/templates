"use client";

import {
  KanbanBoard,
  KanbanCard,
  KanbanCards,
  KanbanHeader,
  KanbanProvider,
  Status,
} from "@/components/roadmap-ui/kanban";
import {
  SalesOrder,
  SalesOrderShipStationOrderStatus,
} from "@/app/lib/IMS/types.generated";
import { salesOrderStatusColors } from "@/lib/colors";
import { useClient } from "urql";
import { useState } from "react";
import type { DragEndEvent } from "@dnd-kit/core";
import { handleShipmentCreation } from "./utils";

type Props = {
  salesOrders: SalesOrder[];
  statuses: Status[];
};

export const SalesOrdersKanban = ({
  salesOrders: initialSalesOrders,
  statuses,
}: Props) => {
  const client = useClient();
  const [salesOrders, setSalesOrders] = useState(initialSalesOrders);

  const handleDragEnd = async (event: DragEndEvent) => {
    const { active, over } = event;

    if (!over) return;

    const newStatus = over.id.toString().toLowerCase();
    const salesOrderId = active.id.toString();

    if (newStatus === "shipped") {
      const order = salesOrders.find((o) => o.id === salesOrderId);
      const shopifyId = order?.shopifyID || null;

      // Optimistically update the UI
      setSalesOrders((prevOrders) =>
        prevOrders.map((order) =>
          order.id === salesOrderId
            ? {
                ...order,
                shipStationOrderStatus:
                  "shipped" as SalesOrderShipStationOrderStatus,
              }
            : order,
        ),
      );

      // Process the shipment
      const success = await handleShipmentCreation(
        client,
        salesOrderId,
        shopifyId,
      );

      // If shipping failed, revert the optimistic update
      if (!success) {
        setSalesOrders((prevOrders) =>
          prevOrders.map((order) =>
            order.id === salesOrderId
              ? {
                  ...order,
                  shipStationOrderStatus:
                    "not_sent" as SalesOrderShipStationOrderStatus,
                }
              : order,
          ),
        );
      }
    }
  };

  // Use the local state instead of the prop
  return (
    <>
      <KanbanProvider onDragEnd={handleDragEnd}>
        {statuses.map(({ id: value, name: label }) => {
          const statusKey = value.toLowerCase();
          const color = salesOrderStatusColors[statusKey] || "bg-gray-300";

          return (
            <KanbanBoard key={value} id={value}>
              <KanbanHeader name={label} color={color} />
              <KanbanCards>
                {salesOrders
                  ?.filter(
                    (order) =>
                      order.shipStationOrderStatus?.toLowerCase() ===
                      value.toLowerCase(),
                  )
                  .map((order, index) => (
                    <KanbanCard
                      key={order.id}
                      id={order.id}
                      name={`#${order.orderNumber}`}
                      parent={value}
                      index={index}
                    >
                      <div className="flex items-start justify-between gap-2">
                        <div className="flex flex-col gap-1">
                          <p className="m-0 flex-1 text-sm font-medium">
                            {order.customerName}
                          </p>
                          <p className="m-0 text-xs text-muted-foreground">
                            {order.customerEmail}
                          </p>
                        </div>
                      </div>
                      <p className="m-0 text-xs text-muted-foreground">
                        {new Intl.NumberFormat("en-US", {
                          style: "currency",
                          currency: order.currency || "USD",
                        }).format(Number(order.currentSubtotalPrice) || 0)}
                      </p>
                    </KanbanCard>
                  ))}
              </KanbanCards>
            </KanbanBoard>
          );
        })}
      </KanbanProvider>
    </>
  );
};
