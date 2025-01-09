"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useMemo } from "react";
import Table from "@/app/(leftpanel)/sales/shipments/table";
import GET_SHIPMENTS from "@/app/lib/IMS/getShipments.gql";
import { Shipment } from "@/app/lib/IMS/types.generated";

const QUERY = gql`
  ${GET_SHIPMENTS}
`;

export default function ShipmentsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({
    query: QUERY,
    requestPolicy: "cache-first",
  });

  const shipments = useMemo(
    () =>
      data?.shipments?.edges?.map((edge: { node: Shipment }) => edge.node) ||
      [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table shipments={shipments} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
}
