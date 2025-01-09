import React from "react";
import { AgGridReact } from "ag-grid-react";
import { useTheme } from "next-themes";
import {
  SideBarDef,
  ColDef,
  themeQuartz,
  CellValueChangedEvent,
} from "ag-grid-enterprise";
import { Skeleton } from "@/components/ui/skeleton";

type DataTableProps<T> = {
  rowData: T[];
  columnDefs: ColDef<T>[];
  sideBar?: SideBarDef | null;
  rowSelection?: "multiple" | "single" | undefined;
  allowDragFromColumnsToolPanel?: boolean;
  rowGroupPanelShow?: "always" | "onlyWhenGrouping";
  pivotPanelShow?: "always" | "onlyWhenPivoting";
  onCellValueChanged?: (event: CellValueChangedEvent<T>) => void;
  fetching: boolean;
  tableHeight?: string;
  tooltipInteraction?: boolean;
  tooltipShowDelay?: number;
  tooltipHideDelay?: number;
};

const LoadingCellRenderer = () => {
  const width = Math.floor(Math.random() * 70 + 30);
  return (
    <div className="flex h-full items-center">
      <Skeleton className="h-4" style={{ width: `${width}%` }} />
    </div>
  );
};

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

export function DataTable<T>(props: DataTableProps<T>) {
  const {
    rowData,
    columnDefs,
    sideBar,
    rowSelection = "multiple",
    allowDragFromColumnsToolPanel = true,
    rowGroupPanelShow = "always",
    pivotPanelShow = "always",
    onCellValueChanged,
    fetching,
    tableHeight = "calc(100vh - 128px)",
    tooltipInteraction = false,
    tooltipShowDelay = 300,
    tooltipHideDelay = 1000,
  } = props;

  const { theme } = useTheme();
  const appliedTheme = theme === "dark" ? myDarkTheme : myLightTheme;

  const enhancedColumnDefs = columnDefs.map((col) => ({
    ...col,
    valueGetter: (params: { data: { [x: string]: unknown } }) => {
      if (fetching) return "loading";
      return params.data?.[col.field as string];
    },
    cellRendererSelector: (params: { value: string }) => {
      if (params.value === "loading") {
        return {
          component: LoadingCellRenderer,
        };
      }
      return undefined;
    },
  }));

  const defaultColDef: ColDef = {
    filter: true,
    floatingFilter: true,
    resizable: true,
    sortable: true,
    enablePivot: true,
    enableRowGroup: true,
    enableValue: true,
    editable: true,
    minWidth: 180,
  };

  const placeholderData = fetching ? Array(rowData?.length || 5).fill({}) : [];
  const displayData = fetching ? placeholderData : rowData;

  return (
    <div
      suppressHydrationWarning
      className={`${appliedTheme} [&_.ag-cell-wrapper.ag-row-group]:items-center`}
      style={{
        width: "100%",
        height: tableHeight,
        overflow: "hidden",
      }}
    >
      <AgGridReact
        rowData={displayData}
        columnDefs={enhancedColumnDefs as ColDef<unknown>[]}
        defaultColDef={defaultColDef}
        rowSelection={rowSelection}
        cellSelection={true}
        allowDragFromColumnsToolPanel={allowDragFromColumnsToolPanel}
        rowGroupPanelShow={rowGroupPanelShow}
        pivotPanelShow={pivotPanelShow}
        sideBar={sideBar}
        onCellValueChanged={onCellValueChanged}
        theme={appliedTheme}
        alwaysShowHorizontalScroll={true}
        tooltipInteraction={tooltipInteraction}
        tooltipHideDelay={tooltipHideDelay}
        tooltipShowDelay={tooltipShowDelay}
      />
    </div>
  );
}
