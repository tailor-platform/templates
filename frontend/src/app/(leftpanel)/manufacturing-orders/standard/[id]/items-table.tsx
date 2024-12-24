"use client";

import React, { useState } from "react";
import { AgGridReact } from "ag-grid-react";
import { MOLineItem } from "@/types";
import { ColDef, RowClickedEvent } from "ag-grid-enterprise";
import { useTheme } from "next-themes";
import { MOLineItemSidePanel } from "./side-panel";
import { InventoryTypeEnumRenderer } from "@/lib/enum-labels";

interface Props {
  moLineItems: MOLineItem[];
}

interface Row {
  id: string;
  requiredQuantity: number;
  totalCost: number;
  itemName: string;
  inventoryType: string;
  originalData: MOLineItem;
}

export const MOLineItemsTab = ({ moLineItems }: Props) => {
  const { theme } = useTheme();
  const [selectedItem, setSelectedItem] = useState<MOLineItem | null>(null);

  const rowData: Row[] = moLineItems.map((item) => ({
    id: item.id,
    requiredQuantity: item.requiredQuantity,
    totalCost: item.totalCost,
    itemName: item.bomLineItem.item.name,
    inventoryType: item.bomLineItem.item.inventoryType,
    originalData: item,
  }));

  const colDefs: ColDef<Row>[] = [
    { field: "itemName", headerName: "Item Name", flex: 1 },
    {
      field: "inventoryType",
      headerName: "Inventory Type",
      flex: 1,
      cellRenderer: InventoryTypeEnumRenderer,
    },
    { field: "requiredQuantity", headerName: "Required Quantity", flex: 1 },
    { field: "totalCost", headerName: "Total Cost", flex: 1 },
  ];

  const handleRowClick = (event: RowClickedEvent<Row>) => {
    if (event.data) {
      setSelectedItem(event.data.originalData);
    }
  };

  return (
    <>
      <div
        className={
          theme === "dark" ? "ag-theme-quartz-dark" : "ag-theme-quartz"
        }
        style={{ width: "100%", height: "80vh" }}
      >
        <AgGridReact
          rowData={rowData}
          columnDefs={colDefs}
          onRowClicked={handleRowClick}
        />
      </div>
      <MOLineItemSidePanel
        moLineItem={selectedItem}
        onClose={() => setSelectedItem(null)}
      />
    </>
  );
};

export default MOLineItemsTab;
