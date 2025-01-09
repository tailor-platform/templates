export const statusColors: Record<string, string> = {
  Draft: "bg-chart-1",
  Planned: "bg-chart-2",
  In_Progress: "bg-chart-3",
  Completed: "bg-chart-4",
  Canceled: "bg-chart-5",
};

export const inventoryTypeColors: Record<string, string> = {
  INVENTORY: "bg-blue-500",
  "NON-INVENTORY": "bg-yellow-500",
  SERVICE: "bg-green-500",
};

export const componentStatusColors: Record<string, string> = {
  Ready: "bg-green-500",
  Pending: "bg-yellow-500",
  In_Progress: "bg-blue-500",
  Blocked: "bg-red-500",
};

export const workOrderStatusColors: Record<string, string> = {
  Draft: "bg-chart-1",
  Waiting_for_another_WO: "bg-chart-2",
  Waiting_for_components: "bg-chart-3",
  In_Progress: "bg-chart-4",
  Finished: "bg-chart-5",
  Canceled: "bg-chart-6",
};

export const salesOrderStatusColors: Record<string, string> = {
  not_sent: "bg-chart-1",
  changes_not_sent: "bg-chart-2",
  awaiting_payment: "bg-chart-3",
  shipped: "bg-chart-4",
};

export const receiptStatusColors: Record<string, string> = {
  OPEN: "bg-green-500",
  CLOSED: "bg-red-500",
};

export const bomTypeColors: Record<string, string> = {
  FINAL_PRODUCT: "bg-chart-1",
  COMPONENT: "bg-chart-2",
  RECIPE: "bg-chart-3",
  KIT: "bg-chart-4",
};
