package master

import (
    "tailor.build/template/seed/utils"
)

// #ReceiptLineItem defines the seed data for ReceiptLineItem entities
#ReceiptLineItem: {
    receiptLineItem0: {
        id: utils.uuid & {_, #type: "ReceiptLineItem", #value: "1"}
        active: true
        receiptStatus: "DRAFT"
        quantity: 100
        receiptID: utils.uuid & {_, #type: "Receipt", #value: "1"}
        subtotalCost: 700
        subtotalUnitCost: 7
        totalCostPoolAllocation: 0
        totalUnitCost: 7
        unitCostPoolAllocation: 0
        variantID: "fe802937-0960-5efa-8f57-27ebfeb144ca"
    }
    receiptLineItem1: {
        id: utils.uuid & {_, #type: "ReceiptLineItem", #value: "2"}
        active: true
        receiptStatus: "DRAFT"
        quantity: 100
        receiptID: utils.uuid & {_, #type: "Receipt", #value: "1"}
        subtotalCost: 700
        subtotalUnitCost: 7
        totalCostPoolAllocation: 0
        totalUnitCost: 7
        unitCostPoolAllocation: 0
        variantID: "52b9942c-5565-5689-ae3b-589121a87da9"
    }
    // Add more receipt line items as needed
}

// ReceiptLineItem aggregates all seed entries into a slice
ReceiptLineItem: {
    items: [
        for _, item in #ReceiptLineItem {
            item
        },
    ]
}