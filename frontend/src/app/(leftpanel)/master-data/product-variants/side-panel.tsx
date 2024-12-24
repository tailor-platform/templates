import { Dispatch, SetStateAction, useMemo } from "react";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { gql } from "@fabrix-framework/fabrix";
import GET_PRODUCT_VARIANT from "@/app/lib/IMS/getProductsVariant.gql";
import { OverviewTab } from "./tab-overview";
type SidePanelProps = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_PRODUCT_VARIANT}
`;

export function SidePanel({ id, onOpenChange }: SidePanelProps) {
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
  const productVariant = data?.productVariant;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && productVariant && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{productVariant.displayName}</SheetTitle>
          </SheetHeader>
          <OverviewTab productVariant={productVariant} />
        </SheetContent>
      )}
    </Sheet>
  );
}
