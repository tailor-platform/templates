"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import GET_STOCK_SUMMARY from "@/app/lib/IMS/getStockSummary.gql";
import { gql } from "@fabrix-framework/fabrix";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/inventory/stock-summary/tab-overview";
import { useQuery } from "urql";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_STOCK_SUMMARY}
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
  const stockSummary = data?.stockSummary;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && stockSummary && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{stockSummary.id}</SheetTitle>
          </SheetHeader>
          <OverviewTab stockSummary={stockSummary} />
        </SheetContent>
      )}
    </Sheet>
  );
}
