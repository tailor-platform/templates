import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { SidePanel } from "./side-panel";
import { PanelRight } from "lucide-react";
import { type Product } from "@/app/lib/IMS/types.generated";
import { DataTable } from "@/components/data-table";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

type Props = {
  products: Product[];
  fetching: boolean;
};

const TableContent = ({ products, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("productId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<Product>[] = [
    {
      field: "title",
      headerName: "Title",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Product>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("productId", params.data?.id ?? null)}`,
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
    { field: "description", headerName: "Description", flex: 1 },
    { field: "handle", headerName: "Handle", flex: 1 },
    { field: "shopifyID", headerName: "Shopify ID", flex: 1 },
    { field: "active", headerName: "Active", flex: 1 },
  ];

  return (
    <>
      <DataTable
        rowData={products}
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
          router.push(`${pathname}?${createQueryString("productId", null)}`);
        }}
      />
    </>
  );
};

export const Table = ({ products, fetching }: Props) => {
  return <TableContent products={products} fetching={fetching} />;
};

export default Table;
