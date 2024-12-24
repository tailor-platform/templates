import { ProductVariant } from "@/app/lib/IMS/types.generated";

type Props = {
  productVariant: ProductVariant;
};

export const OverviewTab = ({ productVariant }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">SKU</span>
            <span className="text-sm text-primary">{productVariant.sku}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Barcode</span>
            <span className="text-sm text-primary">
              {productVariant.barcode}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Price</span>
            <span className="text-sm text-primary">
              ${productVariant.price?.toFixed(2)}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Inventory</span>
            <span className="text-sm text-primary">
              {productVariant.inventoryQuantity}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Available</span>
            <span className="text-sm text-primary">
              {productVariant.availableForSale ? "Yes" : "No"}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
