const manufacturingOrders = {{ getManufacturingOrders.data.manufacturingOrders.collection ?? [] }};

// Define an array of colors
const colors = ["#b89e00", "#eecff3", "#a7f3d0", "#bfdbfe", "#c7d2fe", "#fecaca", "#fcd6bb"];

// Iterate over each center and add the color property
manufacturingOrders.forEach((center, index) => {
  center.color = colors[index % colors.length];
});

return { manufacturingOrders };
