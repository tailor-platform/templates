"use client";

import { Shipment } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/sales/shipments/side-panel";
import { format } from "date-fns";

export const Table = ({
  shipments,
  fetching,
}: {
  shipments: Shipment[];
  fetching: boolean;
}) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("shipmentId");
  console.log("First shipment data:", JSON.stringify(shipments[0], null, 2));

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Shipment>[] = [
    {
      field: "shipmentNumber",
      headerName: "Shipment Number",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Shipment>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("shipmentId", params.data?.id ?? null)}`,
              );
            }}
            className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
          >
            <button className="text-primary-500 hover:opacity-80">
              <PanelRight className="h-4 w-4" />
            </button>
          </div>
          {params.value}
        </div>
      ),
    },
    {
      headerName: "Sales Order",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Shipment>) => {
        const orderNumber = params.data?.salesOrder?.orderNumber;
        return orderNumber ? `SO${orderNumber}` : "N/A";
      },
    },
    {
      headerName: "Customer",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Shipment>) => {
        return params.data?.salesOrder?.customerName || "Unknown";
      },
    },
    {
      field: "createdAt",
      headerName: "Created At",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Shipment>) => {
        if (!params.value) return "";
        return format(new Date(params.value), "MMM d, yyyy");
      },
    },
  ];

  console.log(
    "Full shipments data:",
    shipments.map((s) => ({
      id: s.id,
      shipmentNumber: s.shipmentNumber,
      salesOrder: s.salesOrder
        ? {
            orderNumber: s.salesOrder.orderNumber,
            customerName: s.salesOrder.customerName,
          }
        : null,
    })),
  );

  return (
    <>
      <DataTable
        rowData={shipments}
        columnDefs={colDefs}
        fetching={fetching}
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
          router.push(`${pathname}?${createQueryString("shipmentId", null)}`);
        }}
      />
    </>
  );
};

export default Table;
