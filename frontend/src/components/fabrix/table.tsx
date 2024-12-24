import { TableComponentProps } from "@fabrix-framework/fabrix";
import { AgGridReact } from "ag-grid-react";

export const OMKSTable = (props: TableComponentProps) => {
  const columnDefs = props.headers.map((header) => {
    return {
      headerName: header.key,
      field: header.label,
      enableValue: true,
      enableRowGroup: true,
      enablePivot: true,
    };
  });

  return (
    <div className="ag-theme-quartz" style={{ height: 800 }}>
      <AgGridReact
        columnDefs={columnDefs}
        rowData={props.values}
        sideBar="columns"
        rowGroupPanelShow="always"
      />
    </div>
  );
};
