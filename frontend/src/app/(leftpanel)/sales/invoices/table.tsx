"use client";

import { Invoice } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { Suspense } from "react";
import { SidePanel } from "@/app/(leftpanel)/sales/invoices/side-panel";

type Props = {
  invoices: Invoice[];
  fetching: boolean;
};

const TableContent = ({ invoices, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("invoiceId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Invoice>[] = [
    {
      field: "invoiceStatus",
      headerName: "Status",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Invoice>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("invoiceId", params.data?.id ?? null)}`,
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
      field: "invoiceNumber",
      headerName: "Invoice Number",
      flex: 1,
    },
    {
      field: "customer.name",
      headerName: "Customer",
      flex: 1,
    },
    {
      field: "date",
      headerName: "Date",
      flex: 1,
    },
    {
      field: "shipmentID",
      headerName: "Shipment ID",
    },
  ];

  return (
    <>
      <DataTable
        rowData={invoices}
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
          router.push(`${pathname}?${createQueryString("invoiceId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ invoices, fetching }: Props) => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TableContent invoices={invoices} fetching={fetching} />
    </Suspense>
  );
};
