"use client";

import { useViewContext } from "@/app/(leftpanel)/view-context";
import { gql } from "@fabrix-framework/fabrix";
import { useMemo } from "react";
import { useQuery } from "urql";
import { Table } from "./table";
import GET_PRODUCTS_VARIANTS from "@/app/lib/IMS/getProductsVariants.gql";
import { ProductVariant } from "@/app/lib/IMS/types.generated";

const QUERY = gql`
  ${GET_PRODUCTS_VARIANTS}
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
  const productVariants = useMemo(
    () =>
      data?.productVariants?.edges?.map(
        (edge: { node: ProductVariant }) => edge.node,
      ) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && <Table productVariants={productVariants} />}
    </div>
  );
}
