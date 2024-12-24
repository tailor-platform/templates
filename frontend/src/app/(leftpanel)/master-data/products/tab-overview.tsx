import { Product } from "@/app/lib/IMS/types.generated";

type Props = {
  product: Product;
};

export const OverviewTab = ({ product }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Description</span>
            <span className="text-sm text-primary">{product.description}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Title</span>
            <span className="text-sm text-primary">{product.title}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Handle</span>
            <span className="text-sm text-primary">{product.handle}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Shopify ID</span>
            <span className="text-sm text-primary">{product.shopifyID}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Active</span>
            <span className="text-sm text-primary">
              {product.active ? "Yes" : "No"}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
