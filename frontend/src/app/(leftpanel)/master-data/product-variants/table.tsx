import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { SidePanel } from "./side-panel";
import { PanelRight } from "lucide-react";
import { ProductVariant } from "@/app/lib/IMS/types.generated";
import { DataTable } from "@/components/data-table";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

type Props = {
  productVariants: ProductVariant[];
  fetching: boolean;
};

const TableContent = ({ productVariants, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("variantId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<ProductVariant>[] = [
    {
      field: "displayName",
      headerName: "Title",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<ProductVariant>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("variantId", params.data?.id ?? null)}`,
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
    { field: "sku", headerName: "SKU", flex: 1 },
    { field: "barcode", headerName: "Barcode", flex: 1 },
    {
      field: "price",
      headerName: "Price",
      flex: 1,
      valueFormatter: (params) => {
        if (params.value == null) return "";
        const numValue = Number(params.value);
        return isNaN(numValue) ? "" : numValue.toFixed(2);
      },
    },
    {
      field: "inventoryQuantity",
      headerName: "Inventory",
      flex: 1,
      type: "numericColumn",
    },
    { field: "availableForSale", headerName: "Available", flex: 1 },
    { field: "shopifyID", headerName: "Shopify ID", flex: 1 },
    { field: "active", headerName: "Active", flex: 1 },
  ];

  return (
    <>
      <DataTable
        rowData={productVariants}
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
        onCellValueChanged={(event) => {
          console.log("Cell value changed:", event);
        }}
      />
      <SidePanel
        id={selectedId}
        onOpenChange={(open) => {
          if (open) return;
          router.push(`${pathname}?${createQueryString("variantId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ productVariants, fetching }: Props) => {
  return <TableContent productVariants={productVariants} fetching={fetching} />;
};

export default Table;
