"use client";

import { useViewContext } from "@/app/(leftpanel)/view-context";
import { gql } from "@fabrix-framework/fabrix";
import { useMemo } from "react";
import { useQuery } from "urql";
import { Table } from "./table";
import GET_PRODUCTS from "@/app/lib/IMS/getProducts.gql";
import { Product } from "@/app/lib/IMS/types.generated";

const QUERY = gql`
  ${GET_PRODUCTS}
`;

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

export default function ProductsPage() {
  const { viewType } = useViewContext();
  const [{ data }] = useQuery(queryConfig);
  const products = useMemo(
    () =>
      data?.products?.edges?.map((edge: { node: Product }) => edge.node) || [],
    [data],
  );

  return <div>{viewType === "table" && <Table products={products} />}</div>;
}
