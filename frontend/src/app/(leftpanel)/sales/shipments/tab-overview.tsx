import { Shipment } from "@/app/lib/IMS/types.generated";

type Props = {
  shipment: Shipment;
};

export const OverviewTab = ({ shipment }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Shipment Number
            </span>
            <span className="text-sm text-primary">
              {shipment.shipmentNumber}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Sales Order ID
            </span>
            <span className="text-sm text-primary">
              {shipment.salesOrderID}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Date</span>
            <span className="text-sm text-primary">{shipment.date}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Created At</span>
            <span className="text-sm text-primary">{shipment.createdAt}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Customer</span>
            <span className="text-sm text-primary">
              {shipment.customer?.name}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
