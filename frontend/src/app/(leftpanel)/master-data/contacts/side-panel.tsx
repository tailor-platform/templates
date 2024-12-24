import { Dispatch, SetStateAction, useMemo } from "react";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { gql } from "@fabrix-framework/fabrix";
import GET_CONTACT from "@/app/lib/IMS/getContact.gql";
import { OverviewTab } from "./tab-overview";
import { Contact } from "@/app/lib/IMS/types.generated";

type SidePanelProps = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

const QUERY = gql`
  ${GET_CONTACT}
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
  const contact: Contact = data?.contact;

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && contact && (
        <SheetContent
          className="h-full w-[600px] overflow-auto"
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader>
            <SheetTitle>{contact.name}</SheetTitle>
          </SheetHeader>
          <OverviewTab contact={contact} />
        </SheetContent>
      )}
    </Sheet>
  );
}
