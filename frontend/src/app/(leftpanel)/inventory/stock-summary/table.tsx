"use client";

import { StockSummary } from "@/app/lib/IMS/types.generated";
import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { PanelRight, ExternalLink } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { SidePanel } from "@/app/(leftpanel)/inventory/stock-summary/side-panel";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

type Props = {
  stockSummaries: StockSummary[];
  fetching: boolean;
};

const TableContent = ({ stockSummaries, fetching }: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("stockSummaryId");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const colDefs: ColDef<StockSummary>[] = [
    {
      field: "variantID",
      headerName: "Variant ID",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<StockSummary>) => (
        <div className="group relative flex h-full items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("stockSummaryId", params.data?.id ?? null)}`,
              );
            }}
            className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
          >
            <button className="text-primary-500 hover:opacity-80">
              <PanelRight className="h-4 w-4" />
            </button>
          </div>
          <Badge variant="secondary" className="font-mono text-xs">
            {params.value}
          </Badge>
        </div>
      ),
    },
    {
      field: "variantID",
      headerName: "Shopify Link",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<StockSummary>) => {
        if (!params.data) return null;

        const handle = params.data.variant?.product?.handle;
        if (!handle) return null;

        const shopifyUrl = `https://admin.shopify.com/store/avid-ims-dev-store/products/inventory?selectedColumns=VARIANT_NAME%2CSKU%2CUNAVAILABLE_QUANTITY%2CCOMMITTED_QUANTITY%2CAVAILABLE_QUANTITY%2CON_HAND_QUANTITY%2CINCOMING_QUANTITY&location_id=64971866148?&query=${handle}`;

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
      field: "inStockQuantity",
      headerName: "In Stock Quantity",
      flex: 1,
    },
    {
      field: "averageCost",
      headerName: "Average Cost",
      flex: 1,
    },
    // {
    //   field: "onHoldQuantity",
    //   headerName: "On Hold Quantity",
    //   flex: 1,
    // },
    // {
    //   field: "availableQuantity",
    //   headerName: "Available Quantity",
    //   flex: 1,
    // },
    {
      field: "totalCost",
      headerName: "Total Cost",
      flex: 1,
    },
  ];

  return (
    <>
      <DataTable
        rowData={stockSummaries}
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
            `${pathname}?${createQueryString("stockSummaryId", null)}`,
          );
        }}
      />
    </>
  );
};

export const Table = ({ stockSummaries, fetching }: Props) => {
  return <TableContent stockSummaries={stockSummaries} fetching={fetching} />;
};
