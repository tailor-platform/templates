import { Dispatch, SetStateAction, useMemo } from "react";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { gql } from "@fabrix-framework/fabrix";
import GET_PRODUCT from "@/app/lib/IMS/getProduct.gql";
import { OverviewTab } from "./tab-overview";
import { Product } from "@/app/lib/IMS/types.generated";

type SidePanelProps = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_PRODUCT}
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
  const product: Product = data?.product;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && product && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{product.title}</SheetTitle>
          </SheetHeader>
          <OverviewTab product={product} />
        </SheetContent>
      )}
    </Sheet>
  );
}
