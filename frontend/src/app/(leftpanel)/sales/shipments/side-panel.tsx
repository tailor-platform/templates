"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_SHIPMENT from "@/app/lib/IMS/getShipment.gql";
import { useQuery } from "urql";
import { Shipment } from "@/app/lib/IMS/types.generated";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/sales/shipments/tab-overview";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_SHIPMENT}
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
  const shipment: Shipment = data?.shipment;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && shipment && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{shipment.shipmentNumber}</SheetTitle>
          </SheetHeader>
          <OverviewTab shipment={shipment} />
        </SheetContent>
      )}
    </Sheet>
  );
}
