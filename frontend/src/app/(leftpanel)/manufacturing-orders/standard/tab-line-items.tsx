import {
  Table,
  TableHeader,
  TableRow,
  TableHead,
  TableBody,
  TableCell,
} from "@/components/ui/table";
import { InventoryTypeEnumRenderer } from "@/lib/enum-labels"; // Assuming ShadCN Table is already set up

type BOMLineItem = {
  item: {
    id: string;
    name: string;
    inventoryType: string;
    bomId: string;
  };
  uom: {
    name: string;
    id: string;
  };
};

type MOLineItem = {
  id: string;
  requiredQuantity: number;
  totalCost: number;
  itemMoId: string;
  bomLineItem: BOMLineItem;
};

type MOLineItemEdge = {
  node: MOLineItem;
};

type MOLineItemsTabProps = {
  moLineItems: MOLineItemEdge[];
};

export const MOLineItemsTab = ({ moLineItems }: MOLineItemsTabProps) => {
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
              <TableRow key={index}>
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
