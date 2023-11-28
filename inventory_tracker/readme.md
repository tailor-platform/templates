# Inventory Management

## Overview
Features
* Real-time inventory monitoring by SKU and by location to prevent stock-outs and overselling
* Demand forecasting by SKU and by location to assist in replenishment
* Automate replenishment based on sales velocity and supplier lead times
* Forward and backward traceability from shipment to supplierd.


## Usage
To deploy this template, please refer to the instructions in the [console](https://console.tailor.tech/).

To seed the initial data for your application, run these commands.
As for the `$admin_password`, please check your `./charts/directory/directory.cue` file and see `secret` of `username:    "inventory_tracker_admin"` in the `userList`.

```bash
tailorctl app login -u '$owner_username' -p '$owner_password' #your workspace owner name and password
tailorctl app import -m charts --auto-approve
tailorctl app login -u 'inventory_tracker_admin' -p '$admin_password'
sh seeding.sh
```

## Stock related Event

### Purchase order

### Sales Order

...