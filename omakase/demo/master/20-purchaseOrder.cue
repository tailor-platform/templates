package master

import (
    "tailor.build/template/seed/utils"
)

// #PurchaseOrder defines the seed data for PurchaseOrder entities
#PurchaseOrder: {
    purchaseOrder0: {
        id: utils.uuid & {_, #type: "PurchaseOrder", #value: "1"}
        active: true
        billToID: utils.uuid & {_, #type: "Contact", #value: "3"}
        date: "2024-12-18T19:45:19Z"
        documentNumber: "1234"
        shipToID: utils.uuid & {_, #type: "Contact", #value: "1"}
        shippingContactName: "John Doe"
        shippingContactPhone: "123-456-7890"
        supplierID: utils.uuid & {_, #type: "Contact", #value: "2"}
    }
    // Add more purchase orders as needed
}

// PurchaseOrder aggregates all seed entries into a slice
PurchaseOrder: {
    items: [
        for k, v in #PurchaseOrder {
            v
        },
    ]
}
