const workCenters = {{ workCentersColor.value.workCenters }};

const filterAndAssignColor = (
  workOrders,
  workCenters,
  selectedWorkCenterIds
) => {
  // Create a lookup map for workCenters by id for efficient access
  const workCenterMap = workCenters.reduce((map, wc) => {
    map[wc.id] = wc.color;
    return map;
  }, {});

  // Filter workOrders and assign color
  return workOrders
    .filter(
      (order) =>
        selectedWorkCenterIds.length === 0 ||
        selectedWorkCenterIds.includes(order.operation.workCenterId)
    )
    .map((order) => ({
      ...order,
      workCenterColor: workCenterMap[order.operation.workCenterId],
    }));
};

let workOrders = {{ dashboardCalendarWorkOrders.data.workOrders.collection || [] }};

const selectedFilterofWorkCenter = {{ multiselectListWorkCenter.value }};

const filteredWorkOrders = filterAndAssignColor(
  workOrders,
  workCenters,
  selectedFilterofWorkCenter
);

return { filteredWorkOrders };
