"use client";

import { Item } from "@/app/lib/IMS/types.generated";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/items/side-panel";
import { Suspense } from "react";
import { InventoryTypeEnumRenderer } from "@/lib/enum-labels";

type Props = {
  items: Item[];
  fetching: boolean;
};

const TableContent = ({ items, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("itemId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Item>[] = [
    {
      field: "name",
      headerName: "Name",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Item>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("itemId", params.data?.id ?? null)}`,
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
      field: "inventoryType",
      headerName: "Inventory Type",
      cellRenderer: InventoryTypeEnumRenderer,
      flex: 1,
    },
    {
      field: "isFinalProduct",
      headerName: "Final Product",
      flex: 1,
    },
    {
      field: "bom.name",
      headerName: "Bill Of Material",
      flex: 1,
    },
    {
      field: "uom.name",
      headerName: "Unit of Measure",
      flex: 1,
    },
    {
      field: "quantity",
      headerName: "Quantity",
      flex: 1,
    },
    {
      field: "woAllocatedQuantity",
      headerName: "Work Order Allocated Quantity",
      flex: 1,
    },
    {
      field: "wastedQuantity",
      headerName: "Wasted Quantity",
      flex: 1,
    },
  ];

  return (
    <>
      <DataTable
        rowData={items}
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
          router.push(`${pathname}?${createQueryString("itemId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ items, fetching }: Props) => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TableContent items={items} fetching={fetching} />
    </Suspense>
  );
};
