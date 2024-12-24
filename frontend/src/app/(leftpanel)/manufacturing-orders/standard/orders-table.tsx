import React, { useEffect, useState } from "react";
import { useTheme } from "next-themes";
import { ColDef, ICellRendererParams, themeQuartz } from "ag-grid-enterprise";
import { AgGridReact } from "ag-grid-react";
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

type Props = {
  manufacturingOrders: ManufacturingOrder[];
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

const baseThemeParams = {
  borderRadius: 2,
  fontFamily: {
    googleFont: "Inter",
  },
  fontSize: 13,
  headerFontSize: 14,
  spacing: 6,
  wrapperBorderRadius: 2,
};

const myDarkTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#171717",
  foregroundColor: "#fafafa",
  rowHoverColor: "#262626",
  checkboxCheckedBackgroundColor: "#fff",
  checkboxCheckedShapeColor: "#0a0a0a",
  checkboxCheckedBorderColor: "#fff",
});

const myLightTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#FFFFFF",
  foregroundColor: "#0a0a0a",
  rowHoverColor: "#f5f5f5",
  checkboxCheckedBackgroundColor: "#0a0a0a",
  checkboxCheckedShapeColor: "#fff",
  checkboxCheckedBorderColor: "#0a0a0a",
});

export const StandardManufacturingOrdersTable = ({
  manufacturingOrders,
}: Props) => {
  const { theme } = useTheme();
  const { sidebarPanel } = useSidebarContext();
  const searchParams = useSearchParams();

  const defaultColDef = {
    filter: true,
    floatingFilter: true,
    resizable: true,
    sortable: true,
    enablePivot: true,
    enableRowGroup: true,
    enableValue: true,
    editable: true,
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

  const [selectedId, setSelectedId] = useState<string | null>(null);

  useEffect(() => {
    const id = searchParams.get("id");

    if (id) {
      setSelectedId(id);
    }
  }, [searchParams]);

  const appliedTheme = theme === "dark" ? myDarkTheme : myLightTheme;

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
              setSelectedId(params.data?.id ?? null);
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
    <div
      style={{
        width: "100%",
        height: "80vh",
      }}
      className="[&_.ag-cell-wrapper.ag-row-group]:items-center"
    >
      <AgGridReact
        rowData={rowData}
        columnDefs={colDefs}
        defaultColDef={defaultColDef}
        theme={appliedTheme}
        rowSelection="multiple"
        cellSelection={true}
        rowClass="group"
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
        allowDragFromColumnsToolPanel
        rowGroupPanelShow="always"
        pivotPanelShow="always"
        onCellValueChanged={(event) => {
          console.log("Cell value changed:", event);
        }}
      />
      <MOSidePanel
        id={selectedId}
        onOpenChange={(open) => setSelectedId(open ? selectedId : null)}
      />
    </div>
  );
};

export default StandardManufacturingOrdersTable;
