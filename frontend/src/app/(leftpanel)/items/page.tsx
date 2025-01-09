"use client";

import { gql } from "@fabrix-framework/fabrix";
import GET_ITEMS from "@/app/lib/MO/getItems.gql";
import { useQuery } from "urql";
import { useMemo } from "react";
import { Item } from "@/app/lib/IMS/types.generated";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { Table } from "@/app/(leftpanel)/items/table";

const QUERY = gql`
  ${GET_ITEMS}
`;

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

export default function ItemsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery(queryConfig);
  const items = useMemo(
    () => data?.items?.edges?.map((edge: { node: Item }) => edge.node) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && <Table items={items} fetching={fetching} />}
    </div>
  );
}
