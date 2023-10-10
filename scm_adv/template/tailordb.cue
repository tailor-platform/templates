package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"tailor.build/scm-adv/charts/tailordb:delivery"
	"tailor.build/scm-adv/charts/tailordb:product"
	"tailor.build/scm-adv/charts/tailordb:order"
	"tailor.build/scm-adv/charts/tailordb:location"
	"tailor.build/scm-adv/charts/tailordb:inventoryEvent"
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
					name:   "Delivery"
					schema: delivery.Delivery
				},
				{
					name:   "Product"
					schema: product.Product
				},
				{
					name:   "Order"
					schema: order.Order
				},
				{
					name:   "Location"
					schema: location.Location
				},
				{
					name:   "InventoryEvent"
					schema: inventoryEvent.InventoryEvent
				},
			]
	}
}
