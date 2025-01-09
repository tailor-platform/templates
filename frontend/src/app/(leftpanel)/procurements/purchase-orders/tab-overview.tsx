import { PurchaseOrder } from "@/app/lib/IMS/types.generated";

type Props = {
  purchaseOrder: PurchaseOrder;
};

export const OverviewTab = ({ purchaseOrder }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Purchase Order Number
            </span>
            <span className="text-sm text-primary">
              {purchaseOrder.documentNumber}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Date</span>
            <span className="text-sm text-primary">{purchaseOrder.date}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Supplier</span>
            <span className="text-sm text-primary">
              {purchaseOrder.supplier?.name}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
