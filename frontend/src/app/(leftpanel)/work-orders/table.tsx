"use client";

import { WorkOrder } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { Suspense } from "react";
import { SidePanel } from "@/app/(leftpanel)/work-orders/side-panel";
import { WorkOrderStatusEnumRenderer } from "@/lib/enum-labels";

type Props = {
  workOrders: WorkOrder[];
  fetching: boolean;
};

const TableContent = ({ workOrders, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("workOrderId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<WorkOrder>[] = [
    {
      field: "operation.name",
      headerName: "Operation",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<WorkOrder>) => {
        return (
          <div className="group relative flex items-center pl-6">
            <div
              onClick={(e) => {
                e.stopPropagation();
                router.push(
                  `${pathname}?${createQueryString("workOrderId", params.data?.id ?? null)}`,
                );
              }}
              className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
            >
              <button className="text-primary-500 hover:opacity-80">
                <PanelRight className="h-4 w-4" />
              </button>
            </div>
            {/* Problem: AG Grid should just render what's on the field property,
                but params.value is returning undefined even though the field is correct and the data is there.
                So while we're waiting for support from AG Grid, we're using the data directly.
            */}
            {params.data?.operation?.name}
          </div>
        );
      },
    },
    {
      field: "mo.name",
      headerName: "Manufacturing Order",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<WorkOrder>) =>
        params.data?.mo?.name, // Same problem as above
    },
    {
      field: "status",
      headerName: "Status",
      cellRenderer: WorkOrderStatusEnumRenderer,
      flex: 1,
    },
    {
      field: "expectedDuration",
      headerName: "Expected Duration",
      flex: 1,
    },
    {
      field: "order",
      headerName: "Order",
      flex: 1,
    },
    {
      field: "startDate",
      headerName: "Start Date",
      flex: 1,
    },
    {
      field: "endDate",
      headerName: "End Date",
      flex: 1,
    },
  ];

  return (
    <>
      <DataTable
        rowData={workOrders}
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
          router.push(`${pathname}?${createQueryString("workOrderId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ workOrders, fetching }: Props) => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TableContent workOrders={workOrders} fetching={fetching} />
    </Suspense>
  );
};
