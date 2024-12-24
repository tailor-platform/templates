"use client";

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

const queryConfig = {
  query: QUERY,
  context: {
    requestPolicy: "cache-first" as const,
  },
};

export default function ContactsPage() {
  const { viewType } = useViewContext();
  const [{ data }] = useQuery(queryConfig);
  const contacts: Contact[] = useMemo(
    () =>
      data?.contacts?.edges?.map((edge: { node: Contact }) => edge.node) || [],
    [data],
  );

  return <div>{viewType === "table" && <Table contacts={contacts} />}</div>;
}
