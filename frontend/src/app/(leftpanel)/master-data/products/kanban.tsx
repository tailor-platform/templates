"use client";

import {
  KanbanBoard,
  KanbanCard,
  KanbanCards,
  KanbanHeader,
  KanbanProvider,
  Status,
} from "@/components/roadmap-ui/kanban";
import { DragEndEvent } from "@dnd-kit/core";
import { ManufacturingOrder } from "@/app/(leftpanel)/manufacturing-orders/standard/page";

type Props = {
  manufacturingOrders: ManufacturingOrder[];
  statuses: Status[];
  setManufacturingOrders: (manufacturingOrders: ManufacturingOrder[]) => void;
};

export const StandardManufacturingOrdersKanban = ({
  manufacturingOrders,
  statuses,
  setManufacturingOrders,
}: Props) => {
  const handleDragEnd = (event: DragEndEvent) => {
    const { active, over } = event;

    if (!over) {
      return;
    }

    const newStatus = over.id as string;

    setManufacturingOrders(
      manufacturingOrders.map((order) => {
        if (order.id === active.id) {
          return { ...order, status: newStatus };
        }
        return order;
      }),
    );
  };

  return (
    <KanbanProvider onDragEnd={handleDragEnd}>
      {statuses.map(({ id: value, name: label, color }) => (
        <KanbanBoard key={value} id={value}>
          <KanbanHeader name={label} color={color} />
          <KanbanCards>
            {manufacturingOrders
              ?.filter((order) => order.status === value)
              .map((order, index) => (
                <KanbanCard
                  key={order.id}
                  id={order.id}
                  name={order.name}
                  parent={value}
                  index={index}
                >
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex flex-col gap-1">
                      <p className="m-0 flex-1 text-sm font-medium">
                        {order.name}
                      </p>
                      <p className="m-0 text-xs text-muted-foreground">
                        {order.bom.name}
                      </p>
                    </div>
                  </div>
                  {order.startDateTime && order.endDateTime && (
                    <p className="m-0 text-xs text-muted-foreground">
                      {order.startDateTime} - {order.endDateTime}
                    </p>
                  )}
                </KanbanCard>
              ))}
          </KanbanCards>
        </KanbanBoard>
      ))}
    </KanbanProvider>
  );
};
