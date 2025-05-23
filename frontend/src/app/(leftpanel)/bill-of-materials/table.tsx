"use client";

import { Bom } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/bill-of-materials/side-panel";
import { Suspense } from "react";
import { BomTypeEnumRenderer } from "@/lib/enum-labels";

type Props = {
  boms: Bom[];
  fetching: boolean;
};

const TableContent = ({ boms, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("bomId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Bom>[] = [
    {
      field: "name",
      headerName: "Name",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Bom>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("bomId", params.data?.id ?? null)}`,
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
      field: "sku",
      headerName: "SKU",
      flex: 1,
    },
    {
      field: "description",
      headerName: "Description",
      flex: 1,
    },
    {
      field: "bomType",
      headerName: "BOM Type",
      flex: 1,
      cellRenderer: BomTypeEnumRenderer,
    },
    {
      field: "item.name",
      headerName: "Item",
      flex: 1,
    },
    {
      field: "outputQuantity",
      headerName: "Output Quantity",
      flex: 1,
    },
    {
      field: "uom.name",
      headerName: "UOM",
      flex: 1,
    },
  ];

  return (
    <>
      <DataTable
        rowData={boms}
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
          router.push(`${pathname}?${createQueryString("bomId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ boms, fetching }: Props) => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TableContent boms={boms} fetching={fetching} />
    </Suspense>
  );
};
