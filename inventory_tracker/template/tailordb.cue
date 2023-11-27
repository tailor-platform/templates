package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb/master:product"
	"{{ .Values.cue.package }}/charts/tailordb/master:location"
	"{{ .Values.cue.package }}/charts/tailordb/master:supplier"
	"{{ .Values.cue.package }}/charts/tailordb/transaction:lot"
	"{{ .Values.cue.package }}/charts/tailordb/transaction:purchaseOrder"
	"{{ .Values.cue.package }}/charts/tailordb/transaction:putAway"
	"{{ .Values.cue.package }}/charts/tailordb/transaction:salesOrder"
	"{{ .Values.cue.package }}/charts/tailordb/transaction:shipOut"
	"{{ .Values.cue.package }}/charts/tailordb:stockEvent"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:putAwayCalc"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:supplierLeadTime"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:demandForecast"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:stockEventCalc"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:stockLevel"
	"{{ .Values.cue.package }}/charts/tailordb/calculation:replenishmentAlert"

)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindTailorDB
	spec:    manifest.#SpecTailorDB & {
		namespace: tailordbv1.#Namespace & {
			name:            {{ .Values.tailordb.namespace | quote }}
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					name:   "Product"
					schema: product.Product
				},

				{
					name:   "Location"
					schema: location.Location
				},
				{
					name:   "Supplier"
					schema: supplier.Supplier
				},
				{
					name:   "Lot"
					schema: lot.Lot
				},
				{
					name:   "PurchaseOrder"
					schema: purchaseOrder.PurchaseOrder
				},
				{
					name:   "PutAway"
					schema: putAway.PutAway
				},
				{
					name:   "SalesOrder"
					schema: salesOrder.SalesOrder
				},
				{
					name:   "ShipOut"
					schema: shipOut.ShipOut
				},
				{
					name:   "StockEvent"
					schema: stockEvent.StockEvent
				},
				{
					name:   "putAwayCalc"
					schema: putAwayCalc.putAwayCalc
				},
				{
					name:   "SupplierLeadTime"
					schema: supplierLeadTime.SupplierLeadTime
				},
				{
					name:   "DemandForecast"
					schema: demandForecast.DemandForecast
				},
				{
					name:   "StockEventCalc"
					schema: stockEventCalc.StockEventCalc
				},
				{
					name:   "StockLevel"
					schema: stockLevel.StockLevel
				},
				{
					name:   "ReplenishmentAlert"
					schema: replenishmentAlert.ReplenishmentAlert
				},

			]
	}
}
