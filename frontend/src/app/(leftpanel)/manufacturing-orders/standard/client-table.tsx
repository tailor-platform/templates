"use client";

import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";
import { StandardManufacturingOrdersTable } from "./orders-table";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
  fetching: boolean;
};

export const StandardManufacturingOrdersTableClient = ({
  manufacturingOrders,
  fetching,
}: Props) => {
  return (
    <StandardManufacturingOrdersTable
      manufacturingOrders={manufacturingOrders}
      fetching={fetching}
    />
  );
};
