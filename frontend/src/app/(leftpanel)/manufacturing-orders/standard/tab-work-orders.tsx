import {
  Table,
  TableHeader,
  TableRow,
  TableHead,
  TableBody,
  TableCell,
} from "@/components/ui/table";
import { WorkOrderStatusEnumRenderer } from "@/lib/enum-labels";

type WorkOrder = {
  operation: {
    name: string;
    workCenter: {
      name: string;
    };
  };
  status: string;
  order: number;
  expectedDuration: number;
  realDuration: number;
  startDate: string | null;
  endDate: string | null;
};

type WorkOrderEdge = {
  node: WorkOrder;
};

type MOWorkOrdersTabProps = {
  workOrders: WorkOrderEdge[];
};

export const MOWorkOrdersTab = ({ workOrders }: MOWorkOrdersTabProps) => {
  const workOrderList = workOrders.map((edge) => edge.node);

  return (
    <div>
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Operation</TableHead>
            <TableHead>Work Center</TableHead>
            <TableHead>Status</TableHead>
            <TableHead>Order</TableHead>
            <TableHead>Expected Duration</TableHead>
            <TableHead>Real Duration</TableHead>
            <TableHead>Start Date</TableHead>
            <TableHead>End Date</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {workOrderList.length === 0 ? (
            <TableRow>
              <TableCell colSpan={8} className="text-center">
                No Work Orders Found
              </TableCell>
            </TableRow>
          ) : (
            workOrderList.map((workOrder, index) => (
              <TableRow key={index}>
                <TableCell>{workOrder.operation.name}</TableCell>
                <TableCell>{workOrder.operation.workCenter.name}</TableCell>
                <TableCell>
                  <WorkOrderStatusEnumRenderer value={workOrder.status} />
                </TableCell>
                <TableCell>{workOrder.order}</TableCell>
                <TableCell>{workOrder.expectedDuration}</TableCell>
                <TableCell>{workOrder.realDuration}</TableCell>
                <TableCell>{workOrder.startDate || "N/A"}</TableCell>
                <TableCell>{workOrder.endDate || "N/A"}</TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
    </div>
  );
};
