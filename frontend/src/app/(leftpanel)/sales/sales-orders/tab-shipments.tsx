import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Shipment } from "@/app/lib/IMS/types.generated";

type Props = {
  shipments: { node: Shipment }[];
};

export const ShipmentsTab = ({ shipments }: Props) => {
  return (
    <div className="rounded-xl border p-4">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Shipment #</TableHead>
            <TableHead>Date</TableHead>
            <TableHead>Ship To</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {shipments.map(({ node }) => (
            <TableRow key={node.id}>
              <TableCell>{node.shipmentNumber}</TableCell>
              <TableCell>
                {node.createdAt
                  ? new Date(node.createdAt).toLocaleDateString()
                  : "N/A"}
              </TableCell>
              <TableCell>
                {node.salesOrder?.customerName}
                <br />
                <span className="text-sm text-muted-foreground">
                  {node.salesOrder?.customerEmail}
                </span>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};
