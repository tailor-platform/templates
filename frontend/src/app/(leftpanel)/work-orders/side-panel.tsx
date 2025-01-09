"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import GET_WORK_ORDER from "@/app/lib/MO/getWorkOrder.gql";
import { gql } from "@fabrix-framework/fabrix";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/work-orders/tab-overview";
import { useQuery } from "urql";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_WORK_ORDER}
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
  const workOrder = data?.workOrder;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && workOrder && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{workOrder.id}</SheetTitle>
          </SheetHeader>
          <OverviewTab workOrder={workOrder} />
        </SheetContent>
      )}
    </Sheet>
  );
}
