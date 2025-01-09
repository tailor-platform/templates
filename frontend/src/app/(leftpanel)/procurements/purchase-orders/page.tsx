"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_PURCHASE_ORDERS from "@/app/lib/IMS/getPurchaseOrders.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { PurchaseOrder } from "@/app/lib/IMS/types.generated";
import { Table } from "@/app/(leftpanel)/procurements/purchase-orders/table";
import { useMemo } from "react";

const QUERY = gql`
  ${GET_PURCHASE_ORDERS}
`;

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

const PurchaseOrdersPage = () => {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery(queryConfig);
  const purchaseOrders = useMemo(
    () =>
      data?.purchaseOrders?.edges?.map(
        (edge: { node: PurchaseOrder }) => edge.node,
      ) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table purchaseOrders={purchaseOrders} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
};

export default PurchaseOrdersPage;
