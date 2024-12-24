const manufacturingOrdersColors = {{ moColor.value.manufacturingOrders }};

let workOrders = {{ dashboardManufacturingOrder.data.manufacturingOrders.collection || [] }};

const selectedFilterofMO = {{ multiselectListMO2.value }};

function getFilteredWorkOrders(
  manufacturingOrdersColors,
  workOrders,
  selectedFilterofMO
) {
  // Check if there are selected filters
  const hasSelectedFilters =
    selectedFilterofMO && selectedFilterofMO.length > 0;

  // Filter work orders if there are selected filters, otherwise return all
  const filteredWorkOrders = hasSelectedFilters
    ? workOrders.filter((wo) => selectedFilterofMO.includes(wo.id))
    : workOrders;

  // Map work orders to include the color from manufacturingOrdersColors
  const result = filteredWorkOrders.map((wo) => {
    const matchingMO = manufacturingOrdersColors.find((mo) => mo.id === wo.id);
    return {
      ...wo,
      color: matchingMO ? matchingMO.color : null,
    };
  });

  return result;
}

const result = getFilteredWorkOrders(
  manufacturingOrdersColors,
  workOrders,
  selectedFilterofMO
);

return { result };
