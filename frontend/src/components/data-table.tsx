import React from "react";
import { AgGridReact } from "ag-grid-react";
import { useTheme } from "next-themes";
import { SideBarDef, ColDef, themeQuartz } from "ag-grid-enterprise";

type CellValueChangedEvent<T> = {
  data: T;
  oldValue: unknown;
  newValue: unknown;
  column: ColDef;
  node: unknown;
};

type DataTableProps<T> = {
  rowData: T[];
  columnDefs: ColDef<T>[];
  sideBar?: SideBarDef | null;
  defaultToolPanel?: string | null;
  rowSelection?: "multiple" | "single" | undefined;
  allowDragFromColumnsToolPanel?: boolean;
  rowGroupPanelShow?: "always" | "onlyWhenGrouping";
  pivotPanelShow?: "always" | "onlyWhenPivoting";
  onCellValueChanged?: (event: CellValueChangedEvent<T>) => void;
};

/**
 * Custom DataTable component for the left panel.
 * The theme is based on the themeQuartz theme.
 */

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
  } = props;

  const { theme } = useTheme();
  const appliedTheme = theme === "dark" ? myDarkTheme : myLightTheme;

  const defaultColDef: ColDef = {
    filter: true,
    floatingFilter: true,
    resizable: true,
    sortable: true,
    enablePivot: true,
    enableRowGroup: true,
    enableValue: true,
    editable: true,
  };

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
        columnDefs={columnDefs}
        defaultColDef={defaultColDef}
        theme={appliedTheme}
        rowSelection={rowSelection}
        cellSelection={true}
        rowClass="group"
        allowDragFromColumnsToolPanel={allowDragFromColumnsToolPanel}
        rowGroupPanelShow={rowGroupPanelShow}
        pivotPanelShow={pivotPanelShow}
        onFirstDataRendered={(params) => {
          console.log("First Data Rendered:", params);
        }}
        sideBar={sideBar}
      />
    </div>
  );
}
