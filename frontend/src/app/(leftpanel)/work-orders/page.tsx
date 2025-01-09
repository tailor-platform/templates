"use client";

import { gql } from "@fabrix-framework/fabrix";
import GET_WORK_ORDERS from "@/app/lib/MO/getWorkOrders.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useMemo } from "react";
import { WorkOrder } from "@/app/lib/IMS/types.generated";
import { Table } from "@/app/(leftpanel)/work-orders/table";

const QUERY = gql`
  ${GET_WORK_ORDERS}
`;

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

export default function WorkOrdersPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery(queryConfig);
  const workOrders = useMemo(
    () =>
      data?.workOrders?.edges?.map((edge: { node: WorkOrder }) => edge.node) ||
      [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Table workOrders={workOrders} fetching={fetching} />
      )}
    </div>
  );
}
