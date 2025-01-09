"use client";

import { Suspense } from "react";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useState, useEffect } from "react";
import { StandardManufacturingOrdersTableClient } from "./client-table";
import { StandardManufacturingOrdersKanban } from "./kanban";
import { StandardManufacturingOrdersCalendar } from "./calendar";
import { StandardManufacturingOrdersTimeline } from "./timeline";
import { statusLabels } from "@/lib/enum-labels";
import { statusColors } from "@/lib/colors";
import { gql } from "@fabrix-framework/fabrix";

export type ManufacturingOrder = {
  id: string;
  name: string;
  bom: { name: string };
  quantity?: number;
  status: string;
  componentsStatus?: string;
  startDateTime?: string;
  endDateTime?: string;
  moBatchId?: string;
  item?: { id: string; name: string };
};

const QUERY = gql`
  query {
    manufacturingOrders {
      edges {
        node {
          id
          name
          quantity
          bom {
            name
          }
          status
          componentsStatus
          startDateTime
          endDateTime
          moBatchId
        }
      }
    }
    __type(name: "ManufacturingOrderStatus") {
      enumValues {
        name
      }
    }
  }
`;

export default function StandardManufacturingOrdersPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({ query: QUERY });
  const [statuses, setStatuses] = useState([]);
  const [manufacturingOrders, setManufacturingOrders] = useState<
    ManufacturingOrder[]
  >([]);

  useEffect(() => {
    if (data) {
      const fetchedStatuses = data.__type.enumValues.map(
        (enumValue: { name: string }) => ({
          id: enumValue.name,
          name:
            statusLabels[enumValue.name] || enumValue.name.replace(/_/g, " "),
          color: statusColors[enumValue.name] || "bg-chart-1",
        }),
      );

      const fetchedOrders = data.manufacturingOrders.edges.map(
        ({ node: order }: { node: ManufacturingOrder }) => ({
          ...order,
          startAt: order.startDateTime
            ? new Date(order.startDateTime)
            : new Date(),
          endAt: order.endDateTime ? new Date(order.endDateTime) : new Date(),
        }),
      );

      setStatuses(fetchedStatuses);
      setManufacturingOrders(fetchedOrders);
    }
  }, [data]);

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div>Loading...</div>}>
          <StandardManufacturingOrdersTableClient
            manufacturingOrders={manufacturingOrders}
            fetching={fetching}
          />
        </Suspense>
      )}
      {viewType === "kanban" && (
        <StandardManufacturingOrdersKanban
          manufacturingOrders={manufacturingOrders}
          setManufacturingOrders={setManufacturingOrders}
          statuses={statuses}
        />
      )}
      {viewType === "calendar" && (
        <StandardManufacturingOrdersCalendar
          manufacturingOrders={manufacturingOrders}
          statuses={statuses}
        />
      )}
      {viewType === "timeline" && (
        <StandardManufacturingOrdersTimeline
          manufacturingOrders={manufacturingOrders}
        />
      )}
    </div>
  );
}
