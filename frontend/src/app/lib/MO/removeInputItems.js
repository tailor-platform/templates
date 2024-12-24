const temp = inputQuantities.value;

const itemId = table_simulate_Output_items_input.selectedRow.itemId;

// Check if the itemId already exists in the array
const itemExists = temp.some(existingItem => existingItem.itemId === itemId);

if (itemExists) {
  // If the itemId exists, remove the item from the array
  const newTemp = temp.filter(existingItem => existingItem.itemId !== itemId);
  inputQuantities.setValue(newTemp);
}