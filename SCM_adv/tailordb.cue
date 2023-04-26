package tailordb

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:delivery"
	"{{ .Values.cue.package }}/charts/tailordb:product"
	"{{ .Values.cue.package }}/charts/tailordb:order"
	"{{ .Values.cue.package }}/charts/tailordb:location"
	"{{ .Values.cue.package }}/charts/tailordb:inventoryEvent"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindTailorDB
	spec:    manifest.#SpecTailorDB & {
		namespace: tailordbv1.#Namespace & {
			name:            {{ .Values.tailordb.namespace | quote }}
			organizationId:  {{ generateUUID | quote }}
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					table:  "Delivery"
					schema: delivery.Delivery
				},
				{
					table:  "Product"
					schema: product.Product
				},
				{
					table:  "Order"
					schema: order.Order
				},
				{
					table:  "Location"
					schema: location.Location
				},
				{
					table:  "InventoryEvent"
					schema: inventoryEvent.InventoryEvent
				},
				]
	}
}
