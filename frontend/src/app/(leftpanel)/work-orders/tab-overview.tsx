import { WorkOrder } from "@/app/lib/IMS/types.generated";

type Props = {
  workOrder: WorkOrder;
};

export const OverviewTab = ({ workOrder }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Work Order ID</span>
            <span className="text-sm text-primary">{workOrder.id}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Status</span>
            <span className="text-sm text-primary">{workOrder.status}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Start Date</span>
            <span className="text-sm text-primary">{workOrder.startDate}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Updated At</span>
            <span className="text-sm text-primary">{workOrder.updatedAt}</span>
          </div>
        </div>
      </div>
    </div>
  );
};
