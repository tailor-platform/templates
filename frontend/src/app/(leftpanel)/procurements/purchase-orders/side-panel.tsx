"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_PURCHASE_ORDER from "@/app/lib/IMS/getPurchaseOrder.gql";
import { useQuery } from "urql";
import { OverviewTab } from "@/app/(leftpanel)/procurements/purchase-orders/tab-overview";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_PURCHASE_ORDER}
`;

export function SidePanel({ id, onOpenChange }: Props) {
  const queryConfig = useMemo(
    () => ({
      query: QUERY,
      variables: { id },
      pause: !id,
      context: {
        requestPolicy: "cache-first" as const,
      },
    }),
    [id],
  );

  const [{ data }] = useQuery(queryConfig);
  const purchaseOrder = data?.purchaseOrder;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && purchaseOrder && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{purchaseOrder.documentNumber}</SheetTitle>
          </SheetHeader>
          <OverviewTab purchaseOrder={purchaseOrder} />
        </SheetContent>
      )}
    </Sheet>
  );
  return null;
}
