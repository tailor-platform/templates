import { Badge } from "@/components/ui/badge";
import { ICellRendererParams } from "ag-grid-enterprise";
import { get } from "es-toolkit/compat";
import { PanelRight } from "lucide-react";

export const nestedIDNameColumn = (props: { titlePath: string }) => ({
  enableRowGroup: true,
  enablePivot: true,
  getter: (value: Record<string, unknown>) => value.id,
  renderer: (rendererProps: ICellRendererParams) => {
    const name = get(rendererProps.value, props.titlePath);
    if (!name) {
      return null;
    }

    return (
      <div className="flex h-full items-center">
        <Badge
          className="flex items-center gap-2"
          size="sm"
          variant="secondary"
        >
          {name}
        </Badge>
      </div>
    );
  },
});

export const nameClickableRenderer =
  (props: { onClick: (id: string) => void }) =>
  // eslint-disable-next-line react/display-name
  (params: ICellRendererParams) => {
    return (
      <div className="group relative flex items-center pl-6">
        <div
          onClick={(e) => {
            e.stopPropagation();
            props.onClick(params.data.id);
          }}
          className="invisible absolute inset-y-0 left-0 flex items-center group-hover:visible"
        >
          <button className="text-primary-500 hover:opacity-80">
            <PanelRight className="h-4 w-4" />
          </button>
        </div>
        {params.data.name}
      </div>
    );
  };
