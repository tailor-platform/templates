"use client";

import { Suspense } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_INVOICES from "@/app/lib/IMS/getInvoices.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { Invoice } from "@/app/lib/IMS/types.generated";
import { useMemo } from "react";
import { Table } from "@/app/(leftpanel)/sales/invoices/table";

const QUERY = gql`
  ${GET_INVOICES}
`;

export default function InvoicesPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({
    query: QUERY,
    requestPolicy: "cache-and-network",
  });

  const invoices = useMemo(
    () =>
      data?.invoices?.edges?.map((edge: { node: Invoice }) => edge.node) || [],
    [data],
  );

  return (
    <>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table invoices={invoices} fetching={fetching} />
        </Suspense>
      )}
    </>
  );
}
