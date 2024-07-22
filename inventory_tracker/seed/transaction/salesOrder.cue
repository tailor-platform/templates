package transaction

import (
	"tailor.build/template/seed/utils"
)

#query: """
	mutation (
	    $id: ID,
	    $lotID: ID!,
	    $quantity: Int!,
	    $salesOrderDate: Date!,
	    $customerName: String,
	    $deliveryAddress: String
	    ) {
	        salesOrder1: createSalesOrder(
	            input: {
	                id: $id
	                lotID: $lotID
	                quantity: $quantity
	                salesOrderDate: $salesOrderDate
	                customerName: $customerName
	                deliveryAddress: $deliveryAddress
	            }
	        ) {
	            id
	        }
	    }"""

#SalesOrders: {
	SalesOrder1: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "1"}
		lotID: utils.uuid & {_, #type: "lot", #value: "1"}
		quantity:        5
		salesOrderDate:  "2023-11-10"
		customerName:    "Paul Smith"
		deliveryAddress: "123 Main St, New York, NY 10001"
	}
	SalesOrder2: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "2"}
		lotID: utils.uuid & {_, #type: "lot", #value: "2"}
		quantity:        10
		salesOrderDate:  "2023-11-11"
		customerName:    "John Doe"
		deliveryAddress: "456 Oak St, Los Angeles, CA 90001"
	}
	SalesOrder3: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "3"}
		lotID: utils.uuid & {_, #type: "lot", #value: "3"}
		quantity:        2
		salesOrderDate:  "2023-11-12"
		customerName:    "Jane Doe"
		deliveryAddress: "789 Pine St, Chicago, IL 60601"
	}
	SalesOrder4: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "4"}
		lotID: utils.uuid & {_, #type: "lot", #value: "4"}
		quantity:        5
		salesOrderDate:  "2023-11-13"
		customerName:    "Mary Johnson"
		deliveryAddress: "321 Elm St, Houston, TX 77001"
	}
	SalesOrder5: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "5"}
		lotID: utils.uuid & {_, #type: "lot", #value: "5"}
		quantity:        1
		salesOrderDate:  "2023-11-14"
		customerName:    "James Brown"
		deliveryAddress: "654 Maple St, Philadelphia, PA 19101"
	}
	SalesOrder6: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "6"}
		lotID: utils.uuid & {_, #type: "lot", #value: "6"}
		quantity:        1
		salesOrderDate:  "2023-11-15"
		customerName:    "Patricia Davis"
		deliveryAddress: "987 Cedar St, Phoenix, AZ 85001"
	}
	SalesOrder7: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "7"}
		lotID: utils.uuid & {_, #type: "lot", #value: "7"}
		quantity:        10
		salesOrderDate:  "2023-11-16"
		customerName:    "Robert Miller"
		deliveryAddress: "147 Spruce St, San Antonio, TX 78201"
	}
	SalesOrder8: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "8"}
		lotID: utils.uuid & {_, #type: "lot", #value: "8"}
		quantity:        3
		salesOrderDate:  "2023-11-17"
		customerName:    "Linda Wilson"
		deliveryAddress: "258 Birch St, San Diego, CA 92101"
	}
	SalesOrder9: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "9"}
		lotID: utils.uuid & {_, #type: "lot", #value: "9"}
		quantity:        3
		salesOrderDate:  "2023-11-18"
		customerName:    "Michael Moore"
		deliveryAddress: "369 Walnut St, Dallas, TX 75201"
	}
	SalesOrder10: {
		id: utils.uuid & {_, #type: "salesOrder", #value: "10"}
		lotID: utils.uuid & {_, #type: "lot", #value: "10"}
		quantity:        5
		salesOrderDate:  "2023-11-19"
		customerName:    "Elizabeth Taylor"
		deliveryAddress: "963 Aspen St, San Jose, CA 95101"
	}
}

SalesOrder: {
	items: [
		for k, v in #SalesOrders {
			v
		},
	]
}
