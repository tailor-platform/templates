import { Receipt } from "@/app/lib/IMS/types.generated";

type Props = {
  receipt: Receipt;
};

export const OverviewTab = ({ receipt }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Receipt Number
            </span>
            <span className="text-sm text-primary">
              {receipt.receiptNumber}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Status</span>
            <span className="text-sm text-primary">
              {receipt.receiptStatus}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Date</span>
            <span className="text-sm text-primary">{receipt.date}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Supplier</span>
            <span className="text-sm text-primary">
              {receipt.supplier?.name}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
