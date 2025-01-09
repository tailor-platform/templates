import { ComponentRegistry } from "@fabrix-framework/fabrix";
import { buildOMKSTable } from "./table";
import { OMKSField } from "./field";
import { Badge } from "@/components/ui/badge";
import * as changeCase from "change-case";
import { colorMap } from "./shared";
import { OMKSKanban } from "./kanban";
import { OMKSCalendar } from "./calendar";

const OMKSTable = buildOMKSTable({
  typeRenderers: {
    Enum: (params) => {
      if (!params.value) {
        return null;
      }

      const value = changeCase.capitalCase(params.value as string);
      const color = colorMap[value] ?? "bg-gray-300";

      return (
        <div className="flex h-full items-center">
          <Badge
            className="flex items-center gap-2"
            size="sm"
            variant="secondary"
          >
            <span className={`h-2 w-2 rounded-full ${color}`} />
            {value}
          </Badge>
        </div>
      );
    },
  },
});

export const omakaseFabrixComponents = new ComponentRegistry({
  default: {
    field: OMKSField,
  },
  custom: {
    composite: {
      omksTable: {
        type: "table",
        component: OMKSTable,
      },
      omksKanban: {
        type: "table",
        component: OMKSKanban,
      },
      omksCalendar: {
        type: "table",
        component: OMKSCalendar,
      },
    },
  },
});
