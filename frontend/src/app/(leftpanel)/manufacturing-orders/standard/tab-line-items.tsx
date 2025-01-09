import {
  Table,
  TableHeader,
  TableRow,
  TableHead,
  TableBody,
  TableCell,
} from "@/components/ui/table";
import { InventoryTypeEnumRenderer } from "@/lib/enum-labels"; // Assuming ShadCN Table is already set up
import { MOLineItem } from "@/types";

type MOLineItemEdge = {
  node: MOLineItem;
};

type MOLineItemsTabProps = {
  moLineItems: MOLineItemEdge[];
  onRowSelect?: (row: MOLineItem) => void;
};

export const MOLineItemsTab = ({
  moLineItems,
  onRowSelect,
}: MOLineItemsTabProps) => {
  const lineItemsList = moLineItems.map((edge) => edge.node);

  return (
    <div>
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Item Name</TableHead>
            <TableHead>Inventory Type</TableHead>
            <TableHead>Required Quantity</TableHead>
            <TableHead>Total Cost</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {lineItemsList.length === 0 ? (
            <TableRow>
              <TableCell colSpan={4} className="text-center">
                No Items Found
              </TableCell>
            </TableRow>
          ) : (
            lineItemsList.map((lineItem, index) => (
              <TableRow key={index} onClick={() => onRowSelect?.(lineItem)}>
                <TableCell>{lineItem.bomLineItem.item.name}</TableCell>
                <TableCell>
                  <InventoryTypeEnumRenderer
                    value={lineItem.bomLineItem.item.inventoryType}
                  />
                </TableCell>
                <TableCell>{lineItem.requiredQuantity + " pieces"}</TableCell>
                <TableCell>{"$" + lineItem.totalCost}</TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
    </div>
  );
};
