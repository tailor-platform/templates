"use client";

import { Dispatch, SetStateAction } from "react";
import { useQuery } from "urql";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { OverviewTab } from "./tab-overview";
import { LineItemsTab } from "./tab-line-items";
import { ShipmentsTab } from "./tab-shipments";
import GET_SALES_ORDER from "@/app/lib/IMS/getSalesOrder.gql";
import GET_SALES_ORDER_LINE_ITEMS from "@/app/lib/IMS/getSalesOrdersLineItems.gql";
import GET_SHIPMENTS_BY_SALES_ORDER from "@/app/lib/IMS/getShipmentsBySalesOrder.gql";
import { useSearchParams, useRouter, usePathname } from "next/navigation";
import { gql } from "@fabrix-framework/fabrix";
import { ActivityLog } from "./activity-log";

const QUERIES = {
  SALES_ORDER: gql`
    ${GET_SALES_ORDER}
  `,
  LINE_ITEMS: gql`
    ${GET_SALES_ORDER_LINE_ITEMS}
  `,
  SHIPMENTS: gql`
    ${GET_SHIPMENTS_BY_SALES_ORDER}
  `,
};

type Props = {
  id: string | null;
  onOpenChange: Dispatch<SetStateAction<boolean>>;
};

export function SidePanel({ id, onOpenChange }: Props) {
  const searchParams = useSearchParams();
  const router = useRouter();
  const pathname = usePathname();
  const currentTab = searchParams.get("tab") || "overview";

  const createQueryString = (tab: string) => {
    const params = new URLSearchParams(searchParams);
    params.set("tab", tab);
    return params.toString();
  };

  const [{ data: orderData }] = useQuery({
    query: QUERIES.SALES_ORDER,
    variables: { id },
    pause: !id,
  });

  const [{ data: lineItemsData }] = useQuery({
    query: QUERIES.LINE_ITEMS,
    variables: { salesOrderID: id },
    pause: !id,
  });

  const [{ data: shipmentsData }] = useQuery({
    query: QUERIES.SHIPMENTS,
    variables: { salesOrderID: id },
    pause: !id,
  });

  const salesOrder = orderData?.salesOrder;
  const lineItems = lineItemsData?.salesOrderLineItems?.edges || [];
  const shipments = shipmentsData?.shipments?.edges || [];

  return (
    <Sheet open={!!id} onOpenChange={onOpenChange} modal={false}>
      {id && salesOrder && (
        <SheetContent
          className="h-full overflow-auto"
          style={{ width: "600px", maxWidth: "600px" }}
          overlay={false}
          onInteractOutside={(e) => e.preventDefault()}
        >
          <SheetHeader className="pb-4">
            <SheetTitle>Sales Order {salesOrder.orderNumber}</SheetTitle>
          </SheetHeader>

          <Tabs
            value={currentTab}
            onValueChange={(value) => {
              router.push(`${pathname}?${createQueryString(value)}`);
            }}
          >
            <TabsList>
              <TabsTrigger value="overview">Overview</TabsTrigger>
              <TabsTrigger value="items">Line Items</TabsTrigger>
              <TabsTrigger value="shipments">Shipments</TabsTrigger>
              <TabsTrigger value="lifecycle">Sales Lifecycle</TabsTrigger>
            </TabsList>

            <TabsContent value="overview">
              <OverviewTab salesOrder={salesOrder} />
            </TabsContent>
            <TabsContent value="items">
              <LineItemsTab lineItems={lineItems} />
            </TabsContent>
            <TabsContent value="shipments">
              <ShipmentsTab shipments={shipments} />
            </TabsContent>
            <TabsContent value="lifecycle">
              <ActivityLog />
            </TabsContent>
          </Tabs>
        </SheetContent>
      )}
    </Sheet>
  );
}
