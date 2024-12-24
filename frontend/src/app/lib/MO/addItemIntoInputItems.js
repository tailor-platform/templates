const temp = inputQuantities.value;

const itemId = form_add_item_for_inputquantity.data.itemId;
const item = select_item.selectedItem.item;
const uomId = form_add_item_for_inputquantity.data.uomId;
const inputQuantity = form_add_item_for_inputquantity.data.availableQty;
const uom = select_unitOfMeasure.selectedItem

// Check if the itemId already exists in the array
const itemExists = temp.some(existingItem => existingItem.itemId === itemId);

if (!itemExists) {
  // If the itemId does not exist, add the new item to the array
  temp.push({ item, inputQuantity, itemId, uomId,uom });

  // Update the inputItems value with the new array
  inputQuantities.setValue(temp);
}

form_add_item_for_inputquantity.clear()
select_available_qty.setValue(1)