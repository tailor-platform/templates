"use client";

import React, { useState } from "react";
import { MOLineItem } from "@/types";
import { MOLineItemSidePanel } from "./side-panel";
import { MOLineItemsTab as LineItemsTab } from "../tab-line-items";

interface Props {
  moLineItems: MOLineItem[];
}

export const MOLineItemsTab = ({ moLineItems }: Props) => {
  const [selectedItem, setSelectedItem] = useState<MOLineItem | null>(null);

  const handleRowClick = (item: MOLineItem) => {
    setSelectedItem(item);
  };

  return (
    <>
      <div className="h-[80vh] overflow-y-auto">
        <LineItemsTab
          moLineItems={moLineItems.map((i) => ({ node: i }))}
          onRowSelect={handleRowClick}
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
