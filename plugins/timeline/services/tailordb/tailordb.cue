package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/environment"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/services/tailordb/transaction"
	"tailor.build/template/services/tailordb/timeline"
)

tailordb.#Spec & {
	Namespace: environment.#app.namespace
	Types: [
		{master.Supplier},
		{master.Product},
		{master.User},
		{master.Role},
		{transaction.AdvanceShipmentNotice},
		{transaction.AdvanceShipmentNoticeLineItem},
		{transaction.GoodsReceivedNote},
		{transaction.GoodsReceivedNoteLineItem},
		{transaction.Invoice},
		{transaction.InvoiceLineItem},
		{transaction.RequestForQuote},
		{transaction.RequestForQuoteLineItem},
		{transaction.RequestForQuoteSupplier},
		{transaction.Quote},
		{transaction.QuoteLineItem},
		{transaction.PurchaseOrder},
		{transaction.PurchaseOrderLineItem},
		{timeline.TimelineEntry},
	]
}
