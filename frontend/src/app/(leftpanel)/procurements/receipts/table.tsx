"use client";

import { Receipt } from "@/app/lib/IMS/types.generated";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { Suspense } from "react";
import { SidePanel } from "@/app/(leftpanel)/procurements/receipts/side-panel";
import { ReceiptStatusEnumRenderer } from "@/lib/enum-labels";

type Props = {
  receipts: Receipt[];
  fetching: boolean;
};

const TableContent = ({ receipts, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("receiptId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Receipt>[] = [
    {
      field: "receiptStatus",
      headerName: "Status",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Receipt>) => (
        <div className="group relative flex h-full items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("receiptId", params.data?.id ?? null)}`,
              );
            }}
            className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
          >
            <button className="text-primary-500 hover:opacity-80">
              <PanelRight className="h-4 w-4" />
            </button>
          </div>
          <ReceiptStatusEnumRenderer value={params.value} />
        </div>
      ),
    },
    { field: "receiptNumber", headerName: "Receipt Number", flex: 1 },
    { field: "supplier.name", headerName: "Supplier", flex: 1 },
    { field: "purchaseOrder.id", headerName: "Purchase Order", flex: 1 },
    { field: "date", headerName: "Date", flex: 1 },
  ];

  return (
    <>
      <DataTable
        rowData={receipts}
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
          router.push(`${pathname}?${createQueryString("receiptId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ receipts, fetching }: Props) => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TableContent receipts={receipts} fetching={fetching} />
    </Suspense>
  );
};
