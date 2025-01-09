import { StockSummary } from "@/app/lib/IMS/types.generated";

type Props = {
  stockSummary: StockSummary;
};

export const OverviewTab = ({ stockSummary }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Variant ID</span>
            <span className="text-sm text-primary">
              {stockSummary.variantID}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Average Cost</span>
            <span className="text-sm text-primary">
              {stockSummary.averageCost}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              In Stock Quantity
            </span>
            <span className="text-sm text-primary">
              {stockSummary.inStockQuantity}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              On Hold Quantity
            </span>
            <span className="text-sm text-primary">
              {stockSummary.onHoldQuantity}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Available Quantity
            </span>
            <span className="text-sm text-primary">
              {stockSummary.availableQuantity}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Total Cost</span>
            <span className="text-sm text-primary">
              {stockSummary.totalCost}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
