# Pipeline development

## listPicking

**Input**

* SalesOrderID
* WarehouseID

**Output**
```
"result": [
    {
        "salesOrderLineItemID": "UUID",
        "productID": "UUID-of-Product",
        "product": {
            "name": "Name of the product"
            "upc": "UPC of the product"
        }
        "BinStocks": [
            {
                "ID": "UUID-of-BinStock"
                "binName": "Name of the Bin"
                "quantity": 99
            },            {
                "ID": "UUID-of-BinStock"
                "binName": "Name of the Bin"
                "quantity": 99
            },...
        ],
        "quantity": 10
}]

```

**Steps**

1. Fetch SalesOrderLineItems with input.SalesOrderID (query salesOrderLineItems)
1. Get the list of BinID in the warehouse: Query Bins where Bin.warehouseID = input.warehouseID. This array will be used as a query parameter in the next step. (query bins)
1. For each SalesOrderLineItems of the step 1:
    1. Lookup the Product of the current SalesOrderLineItem from BinStock where `BinStock.BinID in [result-of-the-step2]` This gives a list of BinStock that matches with the SalesOrderLineItem.productID in the warehouse specified by input.warehouseID. (query binStocks)
    1. Create an object that has salesOrderLineItem data and BinID, and the BinStock.quantity
1. Construct a result object that contains the array of SalesOrderLineItem, combined with the BinStock information that stores the relevant product of the LineItem.

