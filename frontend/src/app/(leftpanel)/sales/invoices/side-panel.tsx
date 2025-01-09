"use client";

import { Dispatch, SetStateAction, useMemo } from "react";
import { gql } from "@fabrix-framework/fabrix";
import GET_INVOICE from "@/app/lib/IMS/getInvoice.gql";
import { useQuery } from "urql";
import { OverviewTab } from "@/app/(leftpanel)/sales/invoices/tab-overview";
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
  ${GET_INVOICE}
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
  const invoice = data?.invoice;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && invoice && (
        <SheetContent
          className="h-full overflow-auto"
          style={{ width: "600px", maxWidth: "600px" }}
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{invoice.invoiceNumber}</SheetTitle>
          </SheetHeader>
          <OverviewTab invoice={invoice} />
        </SheetContent>
      )}
    </Sheet>
  );
}
