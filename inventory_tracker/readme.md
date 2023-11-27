# Inventory Management

## Overview
Features
* Real-time inventory monitoring by SKU and by location to prevent stock-outs and overselling
* Demand forecasting by SKU and by location to assist in replenishment
* Automate replenishment based on sales velocity and supplier lead times
* Forward and backward traceability from shipment to supplierd.


## Usage
WIP

To seed the initial data for your application, run these commands.
```bash
tailorctl app login -u '$owner_username' -p '$owner_password' #your workspace owner name and password
tailorctl app import -m charts --auto-approve
```


## Stock related Event

### Purchase order (just create purchaes order)
This happens to purchase the product to increase put away stock.
Purchase order event can be triggered without Sales order.

create

### Ship in for Put away (pipeline resolver)
When purchased product is shipped into the location, this happens.

Create
putaway
stockEvent
lot
putAway_leadTimeCalc

Supplier leadtime
Replanish alert


### Sales Order (just create Sales Order))


### Ship out

Create

Stock event
StockEvent sellOutCalc
Demand Forecast
Stock level
Replanish alert


Q&A
- stock eventは stock out sellout 分けてる訳では無い？
- Stock levelとDemand forecast一緒にしても問題ない？




