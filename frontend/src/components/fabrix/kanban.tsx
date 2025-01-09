import { TableComponentProps } from "@fabrix-framework/fabrix";
import {
  KanbanBoard,
  KanbanCard,
  KanbanCards,
  KanbanHeader,
  KanbanProvider,
} from "../roadmap-ui/kanban";
import * as changeCase from "change-case";
import { colorMap } from "./shared";
import { get } from "es-toolkit/compat";

type OMKSKanbanProps = TableComponentProps<{
  groupByField: string;
  titleField: string;
  descriptionField: string;
}>;

export const OMKSKanban = (props: OMKSKanbanProps) => {
  const enumTypes = props.headers.flatMap((header) => {
    if (header.type?.type !== "Enum") {
      return [];
    }

    return {
      name: header.key,
      values: header.type.meta.values,
    };
  });

  const t = enumTypes.find(
    (type) => type.name === props.customProps.groupByField,
  );
  return (
    <KanbanProvider onDragEnd={() => void 0}>
      {t?.values.map((value) => {
        const label = changeCase.capitalCase(value);
        const color = colorMap[label] ?? "bg-gray-300";

        return (
          <KanbanBoard key={value} id={value}>
            <KanbanHeader name={label} color={color} />
            <KanbanCards>
              {props.values.flatMap((b, index) => {
                const targetValue = b[t.name];
                if (targetValue !== value) {
                  return [];
                }

                if (!("id" in b)) {
                  return [];
                }

                return (
                  <KanbanCard
                    key={b.id as string}
                    id={b.id as string}
                    name={b.id as string}
                    parent={value}
                    index={index}
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="flex flex-col gap-1">
                        <p className="m-0 flex-1 text-sm font-medium">
                          {get(b, props.customProps.titleField) as string}
                        </p>
                        <p className="m-0 text-xs text-muted-foreground">
                          {get(b, props.customProps.descriptionField) as string}
                        </p>
                      </div>
                    </div>
                  </KanbanCard>
                );
              })}
            </KanbanCards>
          </KanbanBoard>
        );
      })}
    </KanbanProvider>
  );
};
