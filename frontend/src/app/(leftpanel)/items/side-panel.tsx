"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_ITEM from "@/app/lib/MO/getItem.gql";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { OverviewTab } from "@/app/(leftpanel)/items/tab-overview";

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_ITEM}
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
  const item = data?.item;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && item && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{item.id}</SheetTitle>
          </SheetHeader>
          <OverviewTab item={item} />
        </SheetContent>
      )}
    </Sheet>
  );
}
