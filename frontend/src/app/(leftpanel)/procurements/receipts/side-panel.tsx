"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_RECEIPT from "@/app/lib/IMS/getReceipt.gql";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/procurements/receipts/tab-overview";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_RECEIPT}
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
  const receipt = data?.receipt;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && receipt && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{receipt.receiptNumber}</SheetTitle>
          </SheetHeader>
          <OverviewTab receipt={receipt} />
        </SheetContent>
      )}
    </Sheet>
  );
}
