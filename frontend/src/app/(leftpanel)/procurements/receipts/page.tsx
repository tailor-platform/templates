"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_RECEIPTS from "@/app/lib/IMS/getReceipts.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { Receipt } from "@/app/lib/IMS/types.generated";
import { useMemo } from "react";
import { Table } from "@/app/(leftpanel)/procurements/receipts/table";

const QUERY = gql`
  ${GET_RECEIPTS}
`;

export default function ReceiptsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({
    query: QUERY,
    requestPolicy: "cache-first",
  });

  const receipts = useMemo(
    () =>
      data?.receipts?.edges?.map((edge: { node: Receipt }) => edge.node) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table receipts={receipts} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
}
