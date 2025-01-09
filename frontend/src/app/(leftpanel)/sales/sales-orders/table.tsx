"use client";

import { SalesOrder } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight, LoaderCircle, ExternalLink } from "lucide-react";
import { SalesOrderStatusEnumRenderer } from "@/lib/enum-labels";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/sales/sales-orders/side-panel";
import { useState, useCallback } from "react";
import { useClient } from "urql";
import { gql } from "@fabrix-framework/fabrix";
import CREATE_SHIPMENT_FROM_SALES_ORDER from "@/app/lib/IMS/createShipmentFromSalesOrder.gql";
import GET_SHIPMENT_LINE_ITEMS from "@/app/lib/IMS/getShipmentLineItems.gql";
import HOLD_SHIPMENT from "@/app/lib/IMS/holdShipment.gql";
import SHIP_SHIPMENT from "@/app/lib/IMS/shipShipment.gql";
import { Button } from "@/components/ui/button";
import UPDATE_SALES_ORDER from "@/app/lib/IMS/updateSalesOrder.gql";
import { SalesOrderSummary } from "./summary";
import { ActivityLog } from "./activity-log";
import { format } from "date-fns";
import GET_SALES_ORDER_LINE_ITEMS_COUNT from "@/app/lib/IMS/getSalesOrdersLineItemsCount.gql";
import GET_SALES_ORDER_SHIPMENTS_COUNT from "@/app/lib/IMS/getSalesOrderShipmentsCount.gql";
import { Badge } from "@/components/ui/badge";
import { handleShipmentCreation } from "./utils";
import { useViewContext } from "@/app/(leftpanel)/view-context";
import { CustomTooltipProps } from "ag-grid-react";

type Props = {
  salesOrders: (SalesOrder & { lifecycleStatus: string })[];
  fetching: boolean;
};

const MUTATIONS = {
  CREATE_SHIPMENT: gql`
    ${CREATE_SHIPMENT_FROM_SALES_ORDER}
  `,
  HOLD_SHIPMENT: gql`
    ${HOLD_SHIPMENT}
  `,
  SHIP_SHIPMENT: gql`
    ${SHIP_SHIPMENT}
  `,
  GET_LINE_ITEMS: gql`
    ${GET_SHIPMENT_LINE_ITEMS}
  `,
  UPDATE_SALES_ORDER: gql`
    ${UPDATE_SALES_ORDER}
  `,
  GET_LINE_ITEMS_COUNT: gql`
    ${GET_SALES_ORDER_LINE_ITEMS_COUNT}
  `,
  GET_SHIPMENTS_COUNT: gql`
    ${GET_SALES_ORDER_SHIPMENTS_COUNT}
  `,
} as const;

const useUrlParams = () => {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const createQueryString = (params: { [key: string]: string | null }) => {
    const newParams = new URLSearchParams(searchParams);
    Object.entries(params).forEach(([name, value]) => {
      if (value === null) {
        newParams.delete(name);
      } else {
        newParams.set(name, value);
      }
    });
    return newParams.toString();
  };

  return { router, pathname, searchParams, createQueryString };
};

export const Table = ({ salesOrders, fetching }: Props) => {
  const client = useClient();
  const { sidebarPanel } = useSidebarContext();
  const { router, pathname, searchParams, createQueryString } = useUrlParams();
  const selectedId = searchParams.get("salesOrderId");
  const { gridConfig } = useViewContext();

  const [loadingStates, setLoadingStates] = useState<Record<string, boolean>>(
    {},
  );

  const handleCreateShipment = async (salesOrderId: string) => {
    try {
      setLoadingStates((prev) => ({
        ...prev,
        [salesOrderId]: true,
      }));

      const order = salesOrders.find((o) => o.id === salesOrderId);
      const shopifyId = order?.shopifyID || null;

      await handleShipmentCreation(client, salesOrderId, shopifyId, () => {
        setShipmentCounts((prev) => ({
          ...prev,
          [salesOrderId]: 1,
        }));
      });
    } finally {
      setLoadingStates((prev) => {
        const newState = { ...prev };
        delete newState[salesOrderId];
        return newState;
      });
    }
  };

  const [lineItemCounts, setLineItemCounts] = useState<Record<string, number>>(
    {},
  );
  const [shipmentCounts, setShipmentCounts] = useState<Record<string, number>>(
    {},
  );

  const fetchLineItemCount = useCallback(
    async (salesOrderId: string) => {
      if (lineItemCounts[salesOrderId] !== undefined) return;

      const result = await client
        .query(MUTATIONS.GET_LINE_ITEMS_COUNT, { salesOrderID: salesOrderId })
        .toPromise();

      const count = result.data?.salesOrderLineItems?.edges?.length || 0;
      setLineItemCounts((prev) => ({
        ...prev,
        [salesOrderId]: count,
      }));
    },
    [client, lineItemCounts],
  );

  const fetchShipmentCount = useCallback(
    async (salesOrderId: string) => {
      if (shipmentCounts[salesOrderId] !== undefined) return;

      try {
        const result = await client
          .query(MUTATIONS.GET_SHIPMENTS_COUNT, { salesOrderID: salesOrderId })
          .toPromise();

        const count = result.data?.shipments?.edges?.length || 0;
        setShipmentCounts((prev) => ({
          ...prev,
          [salesOrderId]: count,
        }));
      } catch (error) {
        console.error("Error fetching shipment count:", error);
        setShipmentCounts((prev) => ({
          ...prev,
          [salesOrderId]: 0,
        }));
      }
    },
    [client, shipmentCounts],
  );

  const colDefs: ColDef<SalesOrder & { lifecycleStatus: string }>[] = [
    {
      field: "orderNumber",
      headerName: "Order Number",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (params.node?.group) return null;

        return (
          <div className="group relative flex h-full items-center pl-6">
            <div
              onClick={(e) => {
                e.stopPropagation();
                void router.push(
                  `${pathname}?${createQueryString({
                    salesOrderId: params.data?.id ?? null,
                    tab: "overview",
                  })}`,
                );
              }}
              className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
            >
              <button className="text-primary-500 hover:opacity-80">
                <PanelRight className="h-4 w-4" />
              </button>
            </div>
            <Badge size="sm" variant="secondary" className="font-mono">
              #{params.value}
            </Badge>
          </div>
        );
      },
    },
    {
      field: "shopifyID",
      headerName: "Shopify Link",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (!params.value) return null;
        const shopifyUrl = `https://admin.shopify.com/store/avid-ims-dev-store/orders/${params.value.replace("gid://shopify/Order/", "")}`;
        return (
          <Button
            variant="link"
            size="sm"
            className="hover:text-primary-500 text-muted-foreground"
            asChild
            onClick={(e) => e.stopPropagation()}
          >
            <a
              href={shopifyUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-1"
            >
              View in Shopify
              <ExternalLink className="h-3 w-3" />
            </a>
          </Button>
        );
      },
    },
    {
      colId: "lineItems",
      headerName: "Line Items",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (params.node?.group) return null;

        if (params.data?.id) {
          void fetchLineItemCount(params.data.id);
        }

        return (
          <div className="flex h-full items-center gap-2">
            <Button
              variant="outline"
              size="xs"
              onClick={(e) => {
                e.stopPropagation();
                void router.push(
                  `${pathname}?${createQueryString({
                    salesOrderId: params.data?.id ?? null,
                    tab: "items",
                  })}`,
                );
              }}
              className="flex items-center"
            >
              <span className="flex items-center text-xs">
                {lineItemCounts[params.data?.id ?? ""] ?? (
                  <LoaderCircle
                    className="h-3 w-3 text-muted-foreground"
                    style={{ animation: "spin 3s linear infinite" }}
                  />
                )}
                &nbsp;Line items
              </span>
            </Button>
          </div>
        );
      },
    },
    {
      colId: "shipments",
      headerName: "Shipments",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (params.node?.group) return null;

        if (params.data?.id) {
          void fetchShipmentCount(params.data.id);
        }

        const shipmentCount = shipmentCounts[params.data?.id ?? ""];
        const isLoading = loadingStates[params.data?.id ?? ""];

        return (
          <div className="flex h-full items-center gap-2">
            {shipmentCount === undefined ? (
              <div className="flex items-center gap-1">
                <LoaderCircle
                  className="h-3 w-3 text-muted-foreground"
                  style={{ animation: "spin 3s linear infinite" }}
                />
                <span className="text-xs">Shipments</span>
              </div>
            ) : shipmentCount > 0 ? (
              <Button
                variant="outline"
                size="xs"
                onClick={(e) => {
                  e.stopPropagation();
                  void router.push(
                    `${pathname}?${createQueryString({
                      salesOrderId: params.data?.id ?? null,
                      tab: "shipments",
                    })}`,
                  );
                }}
              >
                <span className="text-xs">{shipmentCount}&nbsp;Shipments</span>
              </Button>
            ) : (
              <Button
                size="xs"
                variant="outline"
                onClick={() => {
                  if (params.data?.id) {
                    void handleCreateShipment(params.data.id);
                  }
                }}
                disabled={isLoading}
                className="flex min-w-[120px] items-center justify-center gap-1"
              >
                {isLoading ? (
                  <>
                    <LoaderCircle className="h-3 w-3 animate-spin" />
                    <span className="text-xs">Loading...</span>
                  </>
                ) : (
                  <span className="text-xs">Create Shipment</span>
                )}
              </Button>
            )}
          </div>
        );
      },
    },
    {
      field: "shipStationOrderStatus",
      headerName: "Order Status",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        return SalesOrderStatusEnumRenderer(params);
      },
      rowGroup:
        gridConfig?.groupBy?.includes("shipStationOrderStatus") || false,
      hide: gridConfig?.groupBy?.includes("shipStationOrderStatus") || false,
    },
    {
      field: "customerName",
      headerName: "Customer Name",
      flex: 1,
      rowGroup: gridConfig?.groupBy?.includes("customerName") || false,
      hide: gridConfig?.groupBy?.includes("customerName") || false,
      aggFunc: "count",
    },
    {
      field: "customerEmail",
      headerName: "Customer Email",
      flex: 1,
    },
    {
      field: "lifecycleStatus",
      headerName: "Sales Lifecycle",
      editable: false,
      tooltipField: "id",
      tooltipComponent: (props: CustomTooltipProps) => (
        <div className="border-1 min-w-[400px] rounded-md bg-sidebar p-4">
          <div className="flex max-w-full flex-col gap-4">
            <div className="flex items-center justify-between">
              <h3 className="text-lg">Sales Lifecycle</h3>
              <button
                className="text-primary-500 flex items-center"
                onClick={(e) => {
                  e.stopPropagation();
                  void router.push(
                    `${pathname}?${createQueryString({
                      salesOrderId: props.value ?? null,
                      tab: "lifecycle",
                    })}`,
                  );
                }}
              >
                <PanelRight className="h-4 w-4" />
              </button>
            </div>
            <ActivityLog />
          </div>
        </div>
      ),
      flex: 1,
    },
    {
      field: "currentSubtotalPrice",
      headerName: "Subtotal Price",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (params.node?.rowPinned) return null;
        const value = params.value ?? 0;
        const currency = params.data?.currency ?? "USD";
        return (
          <>
            {new Intl.NumberFormat("en-US", {
              style: "currency",
              currency: currency,
            }).format(value)}
          </>
        );
      },
      aggFunc: (params) => {
        let sum = 0;
        params.values.forEach((value) => {
          sum += Number(value) || 0;
        });
        return sum;
      },
      enableValue: true,
      allowedAggFuncs: ["sum"],
      valueFormatter: (params) => {
        if (!params.value && params.value !== 0) return "";
        return new Intl.NumberFormat("en-US", {
          style: "currency",
          currency: "USD",
        }).format(params.value);
      },
    },
    {
      field: "currency",
      headerName: "Currency",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) =>
        params.value && (
          <Badge size="sm" variant="outline" className="font-mono">
            {params.value}
          </Badge>
        ),
    },
    {
      field: "shopifyCreatedAt",
      headerName: "Created At",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (!params.value) return "";
        return format(new Date(params.value), "PPp");
      },
    },
    {
      field: "cancelledAt",
      headerName: "Cancelled At",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<SalesOrder>) => {
        if (!params.value) return "";
        return format(new Date(params.value), "PPp");
      },
    },
    { field: "cancelReason", headerName: "Cancel Reason", flex: 1 },
  ];

  const getTodayOrders = (orders: SalesOrder[]) => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    return orders.filter((order) => {
      const orderDate = new Date(order.shopifyCreatedAt);
      return orderDate >= today;
    });
  };

  const getYesterdayOrders = (orders: SalesOrder[]) => {
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    today.setHours(0, 0, 0, 0);
    yesterday.setHours(0, 0, 0, 0);

    return orders.filter((order) => {
      const orderDate = new Date(order.shopifyCreatedAt);
      return orderDate >= yesterday && orderDate < today;
    });
  };

  const calculateMetrics = (orders: SalesOrder[]) => ({
    totalOrders: orders.length,
    totalRevenue: orders.reduce(
      (sum, order) => sum + Number(order.currentSubtotalPrice || 0),
      0,
    ),
    averageOrderValue: orders.length
      ? orders.reduce(
          (sum, order) => sum + Number(order.currentSubtotalPrice || 0),
          0,
        ) / orders.length
      : 0,
    shippedOrders: orders.filter(
      (order) => order.shipStationOrderStatus?.toLowerCase() === "shipped",
    ).length,
    pendingOrders: orders.filter(
      (order) => order.shipStationOrderStatus?.toLowerCase() === "not_sent",
    ).length,
    cancelledOrders: orders.filter((order) => order.cancelledAt).length,
  });

  const todayOrders = getTodayOrders(salesOrders);
  const yesterdayOrders = getYesterdayOrders(salesOrders);

  const todayMetrics = calculateMetrics(todayOrders);
  const yesterdayMetrics = calculateMetrics(yesterdayOrders);

  const metrics = {
    ...todayMetrics,
    previousTotalOrders: yesterdayMetrics.totalOrders,
    previousTotalRevenue: yesterdayMetrics.totalRevenue,
    previousAverageOrderValue: yesterdayMetrics.averageOrderValue,
    previousCancelledOrders: yesterdayMetrics.cancelledOrders,
  };

  return (
    <div className="flex flex-col gap-2">
      <SalesOrderSummary metrics={metrics} />
      <DataTable
        tableHeight="calc(100vh - 270px)"
        rowData={salesOrders}
        columnDefs={colDefs}
        fetching={fetching}
        tooltipInteraction
        sideBar={{
          toolPanels: [
            {
              id: "columns",
              labelDefault: "Columns",
              labelKey: "columns",
              iconKey: "columns",
              toolPanel: "agColumnsToolPanel",
            },
            {
              id: "filters",
              labelDefault: "Filters",
              labelKey: "filters",
              iconKey: "filter",
              toolPanel: "agFiltersToolPanel",
            },
          ],
          defaultToolPanel: sidebarPanel || undefined,
          hiddenByDefault: !sidebarPanel,
        }}
      />

      <SidePanel
        id={selectedId}
        onOpenChange={(open) => {
          if (open) return;
          router.push(
            `${pathname}?${createQueryString({ salesOrderId: null })}`,
          );
        }}
      />
    </div>
  );
};
