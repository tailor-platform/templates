"use client";

import { gql } from "@fabrix-framework/fabrix";
import GET_BILL_OF_MATERIAL from "@/app/lib/MO/getBillOfMaterial.gql";
import { Dispatch, SetStateAction, useMemo } from "react";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/bill-of-materials/tab-overview";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_BILL_OF_MATERIAL}
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
  const bom = data?.bom;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && bom && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{bom.id}</SheetTitle>
          </SheetHeader>
          <OverviewTab bom={bom} />
        </SheetContent>
      )}
    </Sheet>
  );
}
