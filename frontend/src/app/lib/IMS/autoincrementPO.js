const prefix = "PO";
const padLength = 4;
const increment = 1;

// Extract and parse order numbers to get the highest current value
const documentNumbers = getPurchaseOrders.data.map(item => item.documentNumber);
const numericDocumentNumbers = documentNumbers.map(item => {
  const numericString = item.toString().replace(/\D/g, '');
  if (numericString) {
    // Remove non-numeric characters and parse to integer
    return parseInt(numericString, 10);
  }
  return 0; // Return 0 if numericString is empty or null
});
const highestDocumentNumber = Math.max(...numericDocumentNumbers);

// Format the new order number with the prefix and padded increment
const newDocumentNumber = prefix + (highestDocumentNumber + increment).toString().padStart(padLength, '0');

// Set the new order number in the text input field
return textInput66.setValue(newDocumentNumber);
