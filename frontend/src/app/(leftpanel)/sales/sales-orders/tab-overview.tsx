import {
  SalesOrder,
  SalesOrderShipStationOrderStatus,
} from "@/app/lib/IMS/types.generated";
import { SalesOrderStatusEnumRenderer } from "@/lib/enum-labels";
import { format } from "date-fns";

type Props = {
  salesOrder: SalesOrder;
};

export const OverviewTab = ({ salesOrder }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Sales Order Number
            </span>
            <span className="text-sm text-primary">
              {salesOrder.orderNumber || "-"}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Status</span>
            <span className="text-sm text-primary">
              {salesOrder.shipStationOrderStatus ? (
                <SalesOrderStatusEnumRenderer
                  value={
                    salesOrder.shipStationOrderStatus as SalesOrderShipStationOrderStatus
                  }
                />
              ) : (
                "-"
              )}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Created Date</span>
            <span className="text-sm text-primary">
              {salesOrder.createdAt
                ? format(new Date(salesOrder.createdAt), "MMM d, yyyy")
                : "-"}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Customer Name</span>
            <span className="text-sm text-primary">
              {salesOrder.customerName || "-"}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Customer Email
            </span>
            <span className="text-sm text-primary">
              {salesOrder.customerEmail || "-"}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Subtotal Price
            </span>
            <span className="text-sm text-primary">
              {salesOrder.currentSubtotalPrice
                ? new Intl.NumberFormat("en-US", {
                    style: "currency",
                    currency: salesOrder.currency || "USD",
                  }).format(parseFloat(salesOrder.currentSubtotalPrice))
                : "-"}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Currency</span>
            <span className="text-sm text-primary">
              {salesOrder.currency || "-"}
            </span>
          </div>
          {salesOrder.cancelledAt && (
            <>
              <div className="flex items-center justify-between gap-2">
                <span className="text-sm text-muted-foreground">
                  Cancelled At
                </span>
                <span className="text-sm text-primary">
                  {format(new Date(salesOrder.cancelledAt), "MMM d, yyyy")}
                </span>
              </div>
              <div className="flex items-center justify-between gap-2">
                <span className="text-sm text-muted-foreground">
                  Cancel Reason
                </span>
                <span className="text-sm text-primary">
                  {salesOrder.cancelReason || "-"}
                </span>
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
};
