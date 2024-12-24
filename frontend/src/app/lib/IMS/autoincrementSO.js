const increment = 1;

// Extract and parse order numbers to get the highest current value
const orderNumbers = getSalesOrders.data.map(order => order.orderNumber);

const highestOrderNumber = Math.max(...orderNumbers);

// Format the new order number with the prefix and padded increment
const newOrderNumber = highestOrderNumber + increment;

// Set the new order number in the text input field
return numberInput6.setValue(newOrderNumber);
