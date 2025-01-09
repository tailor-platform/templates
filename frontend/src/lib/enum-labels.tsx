import {
  bomTypeColors,
  componentStatusColors,
  inventoryTypeColors,
  receiptStatusColors,
  salesOrderStatusColors,
  statusColors,
  workOrderStatusColors,
} from "@/lib/colors";
import { Badge } from "@/components/ui/badge";
import React from "react";

export const statusLabels: Record<string, string> = {
  Draft: "Draft",
  Planned: "Planned",
  In_Progress: "In Progress",
  Completed: "Completed",
  Canceled: "Canceled",
};

export const StatusEnumRenderer = <T extends keyof typeof statusColors>({
  value,
}: {
  value: T;
}) => {
  const color = statusColors[value] || "bg-gray-300";
  const label = statusLabels[value] || value;

  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};

// Reverse mapping: Display label -> Enum value
export const reverseStatusLabels: Record<string, string> = Object.fromEntries(
  Object.entries(statusLabels).map(([key, value]) => [value, key]),
);

export const inventoryTypeLabels: Record<string, string> = {
  INVENTORY: "Inventory",
  "NON-INVENTORY": "Non-Inventory",
  SERVICE: "Service",
};

export const InventoryTypeEnumRenderer = <
  T extends keyof typeof inventoryTypeColors,
>({
  value,
}: {
  value: T;
}) => {
  const color = inventoryTypeColors[value] || "bg-gray-300";
  const label = inventoryTypeLabels[value] || value;

  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};

export const componentStatusLabels: Record<string, string> = {
  Ready: "Ready",
  Pending: "Pending",
  In_Progress: "In Progress",
  Blocked: "Blocked",
};

export const ComponentStatusEnumRenderer = <
  T extends keyof typeof componentStatusColors,
>({
  value,
}: {
  value: T;
}) => {
  const color = componentStatusColors[value] || "bg-gray-300";
  const label = componentStatusLabels[value] || value;

  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};

export const workOrderStatusLabels: Record<string, string> = {
  Draft: "Draft",
  Waiting_for_another_WO: "Waiting for another WO",
  Waiting_for_components: "Waiting for components",
  In_Progress: "In Progress",
  Finished: "Finished",
  Canceled: "Canceled",
};
export const WorkOrderStatusEnumRenderer = <
  T extends keyof typeof workOrderStatusColors,
>({
  value,
}: {
  value: T;
}) => {
  const color = workOrderStatusColors[value] || "bg-gray-300";
  const label = workOrderStatusLabels[value] || value;

  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};

export const salesOrderStatusLabels: Record<string, string> = {
  not_sent: "Not sent",
  changes_not_sent: "Changes not sent",
  awaiting_payment: "Awaiting payment",
  shipped: "Shipped",
};

export const SalesOrderStatusEnumRenderer = <
  T extends keyof typeof salesOrderStatusColors,
>({
  value,
}: {
  value: T;
}) => {
  const color = salesOrderStatusColors[value];
  const label = salesOrderStatusLabels[value] || value;
  return (
    color && (
      <div className="flex h-full items-center">
        <Badge
          className="flex items-center gap-2"
          size="sm"
          variant="secondary"
        >
          <span className={`h-2 w-2 rounded-full ${color}`} />
          {label}
        </Badge>
      </div>
    )
  );
};

export const receiptStatusLabels: Record<string, string> = {
  OPEN: "Open",
  CLOSED: "Closed",
};

export const ReceiptStatusEnumRenderer = <
  T extends keyof typeof receiptStatusColors,
>({
  value,
}: {
  value: T;
}) => {
  const color = receiptStatusColors[value] || "bg-gray-300";
  const label = receiptStatusLabels[value] || value;
  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};

export const bomTypeLabels: Record<string, string> = {
  FINAL_PRODUCT: "Final Product",
  COMPONENT: "Component",
  RECIPE: "Recipe",
  KIT: "Kit",
};

export const BomTypeEnumRenderer = <T extends keyof typeof bomTypeColors>({
  value,
}: {
  value: T;
}) => {
  const color = bomTypeColors[value] || "bg-gray-300";
  const label = bomTypeLabels[value] || value;
  return (
    <div className="flex h-full items-center">
      <Badge className="flex items-center gap-2" size="sm" variant="secondary">
        <span className={`h-2 w-2 rounded-full ${color}`} />
        {label}
      </Badge>
    </div>
  );
};
