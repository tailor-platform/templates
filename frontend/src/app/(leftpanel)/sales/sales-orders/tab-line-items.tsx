import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { SalesOrderLineItem } from "@/app/lib/IMS/types.generated";

type Props = {
  lineItems: { node: SalesOrderLineItem }[];
};

export const LineItemsTab = ({ lineItems }: Props) => {
  return (
    <div className="rounded-xl border p-4">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Name</TableHead>
            <TableHead>SKU</TableHead>
            <TableHead>Quantity</TableHead>
            <TableHead>Unit Price</TableHead>
            <TableHead>Subtotal</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {lineItems.map(({ node }) => (
            <TableRow key={node.id}>
              <TableCell>{node.variant?.displayName}</TableCell>
              <TableCell>{node.variant?.sku}</TableCell>
              <TableCell>{node.quantity}</TableCell>
              <TableCell>${node.unitPrice?.toFixed(2)}</TableCell>
              <TableCell>${node.subtotalPrice?.toFixed(2)}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};
