package master

import (
    "tailor.build/template/seed/utils"
)

// #Receipt defines the seed data for Receipt entities
#Receipt: {
    receipt0: {
        id: utils.uuid & {_, #type: "Receipt", #value: "1"}
        active: true
        purchaseOrderID: utils.uuid & {_, #type: "PurchaseOrder", #value: "1"}
        receiptNumber: "Receipt - 1234"
        receiptStatus: "OPEN"
        supplierID: utils.uuid & {_, #type: "Contact", #value: "2"}
    }
    // Add more receipts as needed
}

// Receipt aggregates all seed entries into a slice
Receipt: {
    items: [
        for _, r in #Receipt {
            r
        },
    ]
}
