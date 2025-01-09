"use client";

import { Suspense } from "react";
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

export default function ProductVariantsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({
    query: QUERY,
    requestPolicy: "cache-first",
  });

  const productVariants = useMemo(
    () =>
      data?.productVariants?.edges?.map(
        (edge: { node: ProductVariant }) => edge.node,
      ) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table productVariants={productVariants} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
}
