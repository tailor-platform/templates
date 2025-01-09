"use client";

import { PurchaseOrder } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/procurements/purchase-orders/side-panel";

type Props = {
  purchaseOrders: PurchaseOrder[];
  fetching: boolean;
};

const TableContent = ({ purchaseOrders, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("purchaseOrderId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<PurchaseOrder>[] = [
    {
      field: "documentNumber",
      headerName: "Document Number",
      flex: 1,
      minWidth: 150,
      cellRenderer: (params: ICellRendererParams<PurchaseOrder>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              console.log("params.data?.id", params.data?.id);
              router.push(
                `${pathname}?${createQueryString("purchaseOrderId", params.data?.id ?? null)}`,
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
    { field: "supplier.name", headerName: "Supplier", flex: 1, minWidth: 150 },
    { field: "date", headerName: "Date", flex: 1, minWidth: 150 },
    { field: "terms", headerName: "Terms", flex: 1 },
    { field: "shipTo.name", headerName: "Ship To", flex: 1, minWidth: 150 },
    { field: "shipVia", headerName: "Ship via", flex: 1, minWidth: 150 },
    { field: "dueDate", headerName: "Due Date", flex: 1, minWidth: 150 },
    {
      field: "shippingContactName",
      headerName: "Shipping Contact Name",
      flex: 1,
      minWidth: 150,
    },
    {
      field: "shippingContactPhone",
      headerName: "Shipping Contact Number",
      flex: 1,
      minWidth: 150,
    },
    {
      field: "shippingInstructions",
      headerName: "Shipping Instructions",
      flex: 1,
      minWidth: 150,
    },
    {
      field: "trackingNumber",
      headerName: "Tracking Number",
      flex: 1,
      minWidth: 150,
    },
    { field: "notes", headerName: "Notes", flex: 1, minWidth: 150 },
    { field: "billTo.id", headerName: "Bill To ", flex: 1, minWidth: 150 },
    {
      field: "exFactoryDate",
      headerName: "Ex Factory Date",
      flex: 1,
      minWidth: 150,
    },
    { field: "approvedBy", headerName: "Approved By", flex: 1, minWidth: 150 },
    { field: "receivedBy", headerName: "Received By", flex: 1, minWidth: 150 },
    { field: "pulledBy", headerName: "Pulled By", flex: 1, minWidth: 150 },
  ];

  return (
    <>
      <DataTable
        rowData={purchaseOrders}
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
          router.push(
            `${pathname}?${createQueryString("purchaseOrderId", null)}`,
          );
        }}
      />
    </>
  );
};

export const Table = ({ purchaseOrders, fetching }: Props) => {
  return <TableContent purchaseOrders={purchaseOrders} fetching={fetching} />;
};
