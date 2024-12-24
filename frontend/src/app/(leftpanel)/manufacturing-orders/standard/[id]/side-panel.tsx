import React from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetFooter,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { MOLineItem } from "@/types";

interface MOLineItemSidePanelProps {
  moLineItem: MOLineItem | null;
  onClose: () => void;
}

export const MOLineItemSidePanel = ({
  moLineItem,
  onClose,
}: MOLineItemSidePanelProps) => {
  if (!moLineItem) return null;

  return (
    <Sheet open={!!moLineItem} onOpenChange={onClose}>
      <SheetContent>
        <SheetHeader>
          <SheetTitle>Edit Item</SheetTitle>
        </SheetHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label htmlFor="itemName" className="text-right">
              Item Name
            </Label>
            <Input
              id="itemName"
              value={moLineItem.bomLineItem.item.name}
              className="col-span-3"
              readOnly
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label htmlFor="inventoryType" className="text-right">
              Inventory Type
            </Label>
            <Input
              id="inventoryType"
              value={moLineItem.bomLineItem.item.inventoryType}
              className="col-span-3"
              readOnly
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label htmlFor="requiredQuantity" className="text-right">
              Required Quantity
            </Label>
            <Input
              id="requiredQuantity"
              value={moLineItem.requiredQuantity}
              className="col-span-3"
              readOnly
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label htmlFor="totalCost" className="text-right">
              Total Cost
            </Label>
            <Input
              id="totalCost"
              value={`$${moLineItem.totalCost.toFixed(2)}`}
              className="col-span-3"
              readOnly
            />
          </div>
        </div>
        <SheetFooter>
          <SheetClose asChild>
            <Button type="button" onClick={onClose}>
              Close
            </Button>
          </SheetClose>
        </SheetFooter>
      </SheetContent>
    </Sheet>
  );
};
