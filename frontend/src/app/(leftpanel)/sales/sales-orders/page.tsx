"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_SALES_ORDERS from "@/app/lib/IMS/getSalesOrders.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useMemo, useEffect, useCallback } from "react";
import { SalesOrder } from "@/app/lib/IMS/types.generated";
import { Table } from "@/app/(leftpanel)/sales/sales-orders/table";
import { useRefreshContext } from "@/app/(leftpanel)/refresh-context";
import { SalesOrdersKanban } from "./kanban";
import { SalesOrdersTimeline } from "./timeline";
import { SalesOrdersCalendar } from "./calendar";

const QUERY = gql`
  ${GET_SALES_ORDERS}
`;

export default function SalesOrdersPage() {
  const { viewType } = useViewContext();
  const { setRefreshCallback } = useRefreshContext();
  const [{ data, fetching }, reexecuteQuery] = useQuery({
    query: QUERY,
    requestPolicy: "cache-and-network",
  });

  const salesOrders = useMemo(
    () =>
      data?.salesOrders?.edges?.map((edge: { node: SalesOrder }) => ({
        ...edge.node,

        // Just hardcoding this for demo purposes
        lifecycleStatus: "Manufacture order",
      })) || [],
    [data],
  );

  const refresh = useCallback(async () => {
    await reexecuteQuery({ requestPolicy: "network-only" });
  }, [reexecuteQuery]);

  useEffect(() => {
    setRefreshCallback(refresh);
  }, [setRefreshCallback, refresh]);

  const statuses = [
    { id: "not_sent", name: "Not Sent", color: "bg-gray-300" },
    { id: "shipped", name: "Shipped", color: "bg-green-300" },
    { id: "cancelled", name: "Cancelled", color: "bg-red-300" },
  ];

  return (
    <>
      {viewType === "table" && (
        <Suspense fallback={<div>Loading...</div>}>
          <Table salesOrders={salesOrders} fetching={fetching} />
        </Suspense>
      )}
      {viewType === "kanban" && (
        <SalesOrdersKanban salesOrders={salesOrders} statuses={statuses} />
      )}
      {viewType === "calendar" && (
        <SalesOrdersCalendar salesOrders={salesOrders} statuses={statuses} />
      )}
      {viewType === "timeline" && (
        <SalesOrdersTimeline salesOrders={salesOrders} />
      )}
    </>
  );
}
