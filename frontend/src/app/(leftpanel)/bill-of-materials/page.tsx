"use client";

import { gql } from "@fabrix-framework/fabrix";
import GET_BILL_OF_MATERIALS from "@/app/lib/MO/getBillOfMaterials.gql";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { useQuery } from "urql";
import { useMemo } from "react";
import { Bom } from "@/app/lib/IMS/types.generated";
import { Table } from "@/app/(leftpanel)/bill-of-materials/table";

const QUERY = gql`
  ${GET_BILL_OF_MATERIALS}
`;

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

export default function BillOfMaterialsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery(queryConfig);
  const boms = useMemo(
    () => data?.boms?.edges?.map((edge: { node: Bom }) => edge.node) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && <Table boms={boms} fetching={fetching} />}
    </div>
  );
}
