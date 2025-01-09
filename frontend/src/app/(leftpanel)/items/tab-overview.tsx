import { Item } from "@/app/lib/IMS/types.generated";

type Props = {
  item: Item;
};

export const OverviewTab = ({ item }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Item ID</span>
            <span className="text-sm text-primary">{item.id}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Name</span>
            <span className="text-sm text-primary">{item.name}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Description</span>
            <span className="text-sm text-primary">{item.description}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Created At</span>
            <span className="text-sm text-primary">{item.createdAt}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Updated At</span>
            <span className="text-sm text-primary">{item.updatedAt}</span>
          </div>
        </div>
      </div>
    </div>
  );
};
