import { TableComponentProps } from "@fabrix-framework/fabrix";
import { AgGridReact } from "ag-grid-react";
import {
  ColDef,
  ICellRendererParams,
  ValueFormatterFunc,
  ValueFormatterParams,
} from "ag-grid-enterprise";
import { themeQuartz } from "ag-grid-enterprise";
import { useTheme } from "next-themes";
import { partition } from "es-toolkit";
import * as changeCase from "change-case";
import { useSidebarContext } from "@/app/(leftpanel)/sidebar-context";

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

export type CustomCellRenderer = (
  props: ICellRendererParams,
) => React.ReactNode;

type HeaderProp = {
  label?: string;
  hidden?: boolean;
  fallback?: string;
  formatter?: ValueFormatterFunc;
  renderer?: CustomCellRenderer;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  getter?: (value: any) => any;
  enablePivot?: boolean;
  enableRowGroup?: boolean;
};

export type OMKSCustomHeaderProps = Record<string, HeaderProp>;
export type OMKSTableProps = TableComponentProps<{
  headerProps: OMKSCustomHeaderProps;
}>;

type OMKSTableBuilderProps = {
  typeRenderers: {
    Enum?: CustomCellRenderer;
    Object?: CustomCellRenderer;
    Scalar?: CustomCellRenderer;
    List?: CustomCellRenderer;
  };
};

export const buildOMKSTable =
  (builderProps: OMKSTableBuilderProps) =>
  // eslint-disable-next-line react/display-name
  (props: OMKSTableProps) => {
    const { theme } = useTheme();
    const { sidebarPanel } = useSidebarContext();
    const columnDefs = buildColumns(props, builderProps);

    const appliedTheme = theme === "dark" ? myDarkTheme : myLightTheme;
    return (
      <div
        style={{
          width: "100%",
          height: "80vh",
        }}
        className="[&_.ag-cell-wrapper.ag-row-group]:items-center"
      >
        <AgGridReact
          theme={appliedTheme}
          columnDefs={columnDefs}
          rowData={props.values}
          allowDragFromColumnsToolPanel={true}
          rowGroupPanelShow="always"
          pivotPanelShow="always"
          rowSelection={{
            mode: "singleRow",
            checkboxes: false,
            enableClickSelection: false,
          }}
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
        />
      </div>
    );
  };

const buildColumns = (
  props: OMKSTableProps,
  builderProps: OMKSTableBuilderProps,
) => {
  const [rootValueHeaders] = partition(props.headers, (header) => {
    const splitKey = header.key.split(".");
    return splitKey.length === 1;
  });

  const headerProps = props.customProps.headerProps;
  const columnDefs: Array<ColDef> = rootValueHeaders.map((header) => {
    const headerProp = headerProps[header.key];
    const baseColumnDef = {
      headerName: changeCase.capitalCase(header.key),
      field: header.key,
      filter: true,
      floatingFilter: true,
      resizable: true,
      sortable: true,
      enableValue: true,
      flex: 1,

      enablePivot: headerProp?.enablePivot,
      enableRowGroup: headerProp?.enableRowGroup,
      ...(header.type?.type === "Enum" && {
        enablePivot: true,
        enableRowGroup: true,
      }),
    };

    const fallbackFormatter = (params: ValueFormatterParams) => {
      const cellValue = params.value;
      if (!cellValue) {
        return headerProp?.fallback ?? "N/A";
      }
      return headerProp?.getter ? headerProp.getter(cellValue) : cellValue;
    };

    const defaultRenderer: ColDef = {
      ...baseColumnDef,
      hide: headerProp?.hidden || false,
      valueFormatter: headerProp?.formatter ?? fallbackFormatter,
      cellRenderer: headerProp?.renderer,
    };

    const headerType = header.type?.type;
    if (headerType) {
      const typeRenderer = builderProps.typeRenderers[headerType];
      if (typeRenderer) {
        return {
          ...defaultRenderer,
          cellRenderer: typeRenderer,
        };
      }
    }

    return defaultRenderer;
  });

  return columnDefs;
};
