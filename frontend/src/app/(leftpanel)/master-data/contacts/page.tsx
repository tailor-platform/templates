"use client";

import { Suspense } from "react";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { gql } from "@fabrix-framework/fabrix";
import { useMemo } from "react";
import { useQuery } from "urql";
import { Table } from "./table";
import GET_CONTACTS from "@/app/lib/IMS/getContacts.gql";
import { Contact } from "@/app/lib/IMS/types.generated";

const QUERY = gql`
  ${GET_CONTACTS}
`;

export default function ContactsPage() {
  const { viewType } = useViewContext();
  const [{ data, fetching }] = useQuery({
    query: QUERY,
    requestPolicy: "cache-first",
  });

  const contacts = useMemo(
    () =>
      data?.contacts?.edges?.map((edge: { node: Contact }) => edge.node) || [],
    [data],
  );

  return (
    <div>
      {viewType === "table" && (
        <Suspense fallback={<div></div>}>
          <Table contacts={contacts} fetching={fetching} />
        </Suspense>
      )}
    </div>
  );
}
