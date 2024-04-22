package transactionWithEvent

import (
	"tailor.build/template/seed/utils"
)

#SalesOrders: {
    SalesOrder101: {
        id: utils.uuid & {_, #type: "salesOrder", #value: "101"},
        lotID: utils.uuid & {_, #type: "lot", #value: "101"},
        quantity: 5,
        salesOrderDate: "2023-11-10",
        customerName: "Paul Smith Jr.",
        deliveryAddress: "123 Main St, New York, NY 10001"
    }
}

SalesOrder: {
   items: [
		for k, v in #SalesOrders {
			v
		},
	],
}

