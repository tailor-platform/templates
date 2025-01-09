import { Bom } from "@/app/lib/IMS/types.generated";

type Props = {
  bom: Bom;
};

export const OverviewTab = ({ bom }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">
              Bill Of Material ID
            </span>
            <span className="text-sm text-primary">{bom.id}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Created At</span>
            <span className="text-sm text-primary">{bom.createdAt}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Updated At</span>
            <span className="text-sm text-primary">{bom.updatedAt}</span>
          </div>
        </div>
      </div>
    </div>
  );
};
