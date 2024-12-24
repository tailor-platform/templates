"use client";

import dynamic from "next/dynamic";
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
};

const StandardManufacturingOrdersTable = dynamic(
  () => import("./orders-table"),
  { ssr: false },
);

export const StandardManufacturingOrdersTableClient = ({
  manufacturingOrders,
}: Props) => {
  return (
    <StandardManufacturingOrdersTable
      manufacturingOrders={manufacturingOrders}
    />
  );
};
