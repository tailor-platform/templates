
const filterAndAssignColor = (
  workOrders,
  workCenters,
  selectedWorkCenterIds,
  dependentWorkOrders,
  selectedFilterOfManufacturingOrder
) => {
  // Create a lookup map for workCenters by id for efficient access
  const workCenterMap = workCenters.reduce((map, wc) => {
    map[wc.id] = wc.color;
    return map;
  }, {});

  // Create a dependencies map to store each workOrder's dependencies
  const dependenciesMap = dependentWorkOrders.reduce((map, dependency) => {
    if (!map[dependency.workOrderId]) {
      map[dependency.workOrderId] = [];
    }
    map[dependency.workOrderId].push(dependency.dependsOnWorkOrderId);
    return map;
  }, {});

  // Filter workOrders based on workCenterIds and manufacturingOrderIds
  const filteredOrders = workOrders
    .filter((order) => {
      const isWorkCenterSelected = 
        selectedWorkCenterIds.length === 0 || 
        selectedWorkCenterIds.includes(order.operation.workCenterId);

      const isManufacturingOrderSelected = 
        selectedFilterOfManufacturingOrder.length === 0 || 
        selectedFilterOfManufacturingOrder.includes(order.mo.id);

      return isWorkCenterSelected && isManufacturingOrderSelected;
    })
    .map((order) => ({
      ...order,
      workCenterColor: workCenterMap[order.operation.workCenterId],
      dependencies: dependenciesMap[order.id] || [], // Add dependencies array
    }));

  console.log("Filtered Orders:", filteredOrders);
  return filteredOrders;
};


const workCenters = {{ workCentersColor.value.workCenters }};
let workOrders = {{ dashboardCalendarWorkOrders.data.workOrders.collection || [] }};

let dependentWorkOrders = {{ workOrderDependency.data.workOrderDependencies.collection }}

const selectedFilterofWorkCenter = {{ multiselectListWorkCenter2.value }};
const selectedFilterofManufacturingOrder = {{ multiselectListMO3.value }};

const filteredWorkOrders = filterAndAssignColor(
  workOrders,
  workCenters,
  selectedFilterofWorkCenter,
  dependentWorkOrders,
  selectedFilterofManufacturingOrder
);

return { filteredWorkOrders };
