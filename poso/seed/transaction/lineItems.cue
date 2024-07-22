package transaction

import (
	"tailor.build/template/seed/utils"
)

#LineItems: [
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "1"}
		documentID: utils.uuid & {_, #type: "document", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "1"}
		quantity:  1
		name:      "BOS Item"
		unitPrice: 100
		unitCost:  0
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "2"}
		documentID: utils.uuid & {_, #type: "document", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "2"}
		quantity:  10
		name:      "Solar Panel"
		unitPrice: 370
		unitCost:  240
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "3"}
		documentID: utils.uuid & {_, #type: "document", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "3"}
		quantity:  7
		name:      "Mounting Brackets"
		unitPrice: 45
		unitCost:  30
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "4"}
		documentID: utils.uuid & {_, #type: "document", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "4"}
		quantity:  10
		name:      "Inverter"
		unitPrice: 750
		unitCost:  500
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "5"}
		documentID: utils.uuid & {_, #type: "document", #value: "1"}
		productID: utils.uuid & {_, #type: "product", #value: "5"}
		quantity:  10
		name:      "Wiring"
		unitPrice: 150
		unitCost:  100
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "6"}
		documentID: utils.uuid & {_, #type: "document", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "1"}
		quantity:  1
		name:      "BOS Item"
		unitPrice: -3200
		unitCost:  0
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "7"}
		documentID: utils.uuid & {_, #type: "document", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "2"}
		quantity:  10
		name:      "Solar Panel"
		unitPrice: 370
		unitCost:  240
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "8"}
		documentID: utils.uuid & {_, #type: "document", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "3"}
		quantity:  7
		name:      "Mounting Brackets"
		unitPrice: 45
		unitCost:  30
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "9"}
		documentID: utils.uuid & {_, #type: "document", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "4"}
		quantity:  10
		name:      "Inverter"
		unitPrice: 750
		unitCost:  500
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "10"}
		documentID: utils.uuid & {_, #type: "document", #value: "2"}
		productID: utils.uuid & {_, #type: "product", #value: "5"}
		quantity:  10
		name:      "Wiring"
		unitPrice: 150
		unitCost:  100
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "11"}
		documentID: utils.uuid & {_, #type: "document", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "1"}
		quantity:  1
		name:      "BOS Item"
		unitPrice: -3200
		unitCost:  0
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "12"}
		documentID: utils.uuid & {_, #type: "document", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "2"}
		quantity:  10
		name:      "Solar Panel"
		unitPrice: 370
		unitCost:  240
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "13"}
		documentID: utils.uuid & {_, #type: "document", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "3"}
		quantity:  7
		name:      "Mounting Brackets"
		unitPrice: 45
		unitCost:  30
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "14"}
		documentID: utils.uuid & {_, #type: "document", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "4"}
		quantity:  10
		name:      "Inverter"
		unitPrice: 750
		unitCost:  500
	},
	{
		id: utils.uuid & {_, #type: "lineItem", #value: "15"}
		documentID: utils.uuid & {_, #type: "document", #value: "3"}
		productID: utils.uuid & {_, #type: "product", #value: "5"}
		quantity:  10
		name:      "Wiring"
		unitPrice: 150
		unitCost:  100
	},

]

LineItem: {
	items: [
		for k, v in #LineItems {
			lineItems: [
				{
					id:        v.id
					productID: v.productID
					quantity:  v.quantity
					name:      v.name
					unitCost:  v.unitCost
					unitPrice: v.unitPrice
					taxID:     null
				},
			]
			documentID: v.documentID
		},
	]
	query: """
		mutation BulkUpsertAndCalculateLineItems(
			$input: bulkUpsertAndCalculateLineItemsInput!
		) {
			bulkUpsertAndCalculateLineItems(
				input: $input
			) {
				result
				error
			}
		}
		"""
}
