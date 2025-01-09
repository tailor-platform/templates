import { ColDef, ICellRendererParams } from "ag-grid-enterprise";
import { Badge } from "@/components/ui/badge";
import {
  ComponentStatusEnumRenderer,
  StatusEnumRenderer,
} from "@/lib/enum-labels";
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";
import { MOSidePanel } from "./side-panel";
import { useSearchParams } from "next/navigation";
import { PanelRight } from "lucide-react";
import { DataTable } from "@/components/data-table";
import { useRouter, usePathname } from "next/navigation";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
  fetching: boolean;
};

const QuantityRenderer = <T extends string | number>({
  value,
}: {
  value: T;
}) => {
  const quantity =
    typeof value === "number" ? value : parseFloat(value as string);
  const unit = quantity === 1 ? "piece" : "pieces";

  return quantity ? (
    <div className="flex flex-row items-center gap-2">
      {quantity}
      <span className="text-foreground">{unit}</span>
    </div>
  ) : null;
};

const MOBatchIdRenderer = <T extends string | number>({
  value,
}: {
  value: T;
}) => {
  return value ? (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        {value}
      </Badge>
    </div>
  ) : null;
};

interface Row {
  id: string;
  name: string;
  bom: { name: string };
  quantity: number;
  status: string;
  componentsStatus: string;
  startDateTime: string;
  endDateTime: string;
  moBatchId: string;
}

export const StandardManufacturingOrdersTable = ({
  manufacturingOrders,
  fetching,
}: Props) => {
  const { sidebarPanel } = useSidebarContext();
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const selectedId = searchParams.get("id");

  const createQueryString = (name: string, value: string | null) => {
    const params = new URLSearchParams(searchParams);
    if (value === null) {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    return params.toString();
  };

  const rowData: Row[] = manufacturingOrders.map((order) => ({
    id: order.id,
    name: order.name,
    bom: order.bom,
    quantity: order.quantity ?? 0,
    status: order.status,
    componentsStatus: order.componentsStatus || "N/A",
    startDateTime: order.startDateTime || "N/A",
    endDateTime: order.endDateTime || "N/A",
    moBatchId: order.moBatchId || "N/A",
  }));

  const colDefs: ColDef<Row>[] = [
    {
      field: "name",
      headerName: "Name",
      flex: 1,
      cellRenderer: (params: ICellRendererParams<Row>) => (
        <div className="group relative flex items-center pl-6">
          <div
            onClick={(e) => {
              e.stopPropagation();
              router.push(
                `${pathname}?${createQueryString("id", params.data?.id ?? null)}`,
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
    { field: "bom.name", headerName: "BOM", flex: 1, editable: false },
    {
      field: "quantity",
      headerName: "Quantity",
      cellRenderer: QuantityRenderer,
      flex: 1,
      valueParser: (params) => Number(params.newValue),
    },
    {
      field: "status",
      headerName: "Status",
      cellRenderer: StatusEnumRenderer,
      flex: 1,
    },
    {
      field: "componentsStatus",
      headerName: "Components Status",
      cellRenderer: ComponentStatusEnumRenderer,
      flex: 1,
    },
    { field: "startDateTime", headerName: "Start Date Time", flex: 1 },
    { field: "endDateTime", headerName: "End Date Time", flex: 1 },
    {
      field: "moBatchId",
      headerName: "MO Batch ID",
      cellRenderer: MOBatchIdRenderer,
      flex: 1,
    },
  ];

  return (
    <>
      <DataTable
        rowData={rowData}
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
      <MOSidePanel
        id={selectedId}
        onOpenChange={(open) => {
          if (open) return;
          router.push(`${pathname}?${createQueryString("id", null)}`);
        }}
      />
    </>
  );
};

export default StandardManufacturingOrdersTable;
