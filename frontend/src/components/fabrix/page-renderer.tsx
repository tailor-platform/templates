import { omakaseFabrixComponents } from "@/components/fabrix/components";
import { useViewContext } from "../../app/(leftpanel)/view-context";
import { ComponentProps } from "react";
import { DocumentNode } from "graphql";

const OMKSTable = omakaseFabrixComponents.getFabrixComponent("omksTable");
const OMKSKanban = omakaseFabrixComponents.getFabrixComponent("omksKanban");
const OMKSCalendar = omakaseFabrixComponents.getFabrixComponent("omksCalendar");

type PageProps = {
  query: DocumentNode | string;
  table: ComponentProps<typeof OMKSTable>["customProps"];
  kanban: ComponentProps<typeof OMKSKanban>["customProps"];
  calendar: ComponentProps<typeof OMKSCalendar>["customProps"];
};

export const ViewerRenderer = (props: { pageProps: PageProps }) => {
  const { viewType } = useViewContext();

  switch (viewType) {
    case "table":
      return (
        <OMKSTable
          query={props.pageProps.query}
          customProps={{
            ...props.pageProps.table,
          }}
        />
      );
    case "kanban":
      return (
        <OMKSKanban
          query={props.pageProps.query}
          customProps={props.pageProps.kanban}
        />
      );
    case "calendar":
      return (
        <OMKSCalendar
          query={props.pageProps.query}
          customProps={props.pageProps.calendar}
        />
      );
    default:
      return null;
  }
};
