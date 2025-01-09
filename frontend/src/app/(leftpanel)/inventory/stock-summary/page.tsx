"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_STOCK_SUMMARIES from "@/app/lib/IMS/getStockSummaries.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useMemo, useEffect, useCallback } from "react";
import { StockSummary } from "@/app/lib/IMS/types.generated";
import { Table } from "@/app/(leftpanel)/inventory/stock-summary/table";
import { useRefreshContext } from "@/app/(leftpanel)/refresh-context";

const QUERY = gql`
  ${GET_STOCK_SUMMARIES}
`;

export default function StockSummaryPage() {
  const { viewType } = useViewContext();
  const { setRefreshCallback } = useRefreshContext();
  const [{ data, fetching }, reexecuteQuery] = useQuery({
    query: QUERY,
    requestPolicy: "cache-and-network",
  });

  const stockSummaries = useMemo(
    () =>
      data?.stockSummaries?.edges?.map(
        (edge: { node: StockSummary }) => edge.node,
      ) || [],
    [data],
  );

  const refresh = useCallback(async () => {
    await reexecuteQuery({ requestPolicy: "network-only" });
  }, [reexecuteQuery]);

  useEffect(() => {
    setRefreshCallback(refresh);
  }, [setRefreshCallback, refresh]);

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table stockSummaries={stockSummaries} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
}
