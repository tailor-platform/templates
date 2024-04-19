package tailordb

import (
  "github.com/tailor-platform/tailorctl/schema/v2/tailordb"
  "tailor.build/template/environment"
  "tailor.build/template/manifest/services/tailordb/master"
  "tailor.build/template/manifest/services/tailordb/transaction"
)

tailordb.#Spec & {
  Namespace: environment.#app.namespace,
  Types: [
    { master.Supplier },
    { master.Product },
    { master.User },
    { master.Role },
    { transaction.AdvanceShipmentNotice },
    { transaction.AdvanceShipmentNoticeLineItem },
    { transaction.GoodsReceivedNote },
    { transaction.GoodsReceivedNoteLineItem },
    { transaction.Invoice },
    { transaction.InvoiceLineItem },
    { transaction.RequestForQuote },
    { transaction.RequestForQuoteLineItem },
    { transaction.RequestForQuoteSuppliers },
    { transaction.Quote },
    { transaction.QuoteLineItem },
    { transaction.PurchaseOrder },
    { transaction.PurchaseOrderLineItem }
  ]
}
