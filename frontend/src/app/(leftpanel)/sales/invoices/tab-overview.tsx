import { Invoice } from "@/app/lib/IMS/types.generated";

type Props = {
  invoice: Invoice;
};

export const OverviewTab = ({ invoice }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Invoice Number
            </span>
            <span className="text-sm text-primary">
              {invoice.invoiceNumber}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Status</span>
            <span className="text-sm text-primary">
              {invoice.invoiceStatus}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Date</span>
            <span className="text-sm text-primary">{invoice.date}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Customer</span>
            <span className="text-sm text-primary">
              {invoice.customer?.name}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
