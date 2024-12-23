package master

import (
    "tailor.build/template/seed/utils"
)

// #PurchaseOrderLineItem defines the seed data for PurchaseOrderLineItem entities
#PurchaseOrderLineItem: {
    purchaseOrderLineItem0: {
        id: utils.uuid & {_, #type: "PurchaseOrderLineItem", #value: "1"}
        active: true
        purchaseOrderID: utils.uuid & {_, #type: "PurchaseOrder", #value: "1"}
        subtotalCost: 700
        unitCost: 7
        quantity: 100
        variantID: "fe802937-0960-5efa-8f57-27ebfeb144ca"
    }
    purchaseOrderLineItem1: {
        id: utils.uuid & {_, #type: "PurchaseOrderLineItem", #value: "2"}
        active: true
        purchaseOrderID: utils.uuid & {_, #type: "PurchaseOrder", #value: "1"}
        subtotalCost: 700
        unitCost: 7
        quantity: 100
        variantID: "52b9942c-5565-5689-ae3b-589121a87da9"
    }
    // Add more purchase order line items as needed
}

// PurchaseOrderLineItem aggregates all seed entries into a slice
PurchaseOrderLineItem: {
    items: [
        for k, v in #PurchaseOrderLineItem {
            v
        },
    ]
}
