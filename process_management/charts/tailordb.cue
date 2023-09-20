package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/tailordb:product"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/tailordb:material"
	"tailor.build/alascop-process-mgmt-demo-ntldvzkd/charts/tailordb:inventoryEvent"
)

manifest.#TailorManifest & {
	version: "v1"
	kind:    manifest.#KindTailorDB
	spec:    manifest.#SpecTailorDB & {
		namespace: tailordbv1.#Namespace & {
			name:            "alascop-process-mgmt-demo-ntldvzkd"
			defaultTimezone: "UTC"
		}
		manifests: [...tailordbv1.#Manifest] &
			[
				{
					name:   "Product"
					schema: product.Product
				},
				{
					name:   "Material"
					schema: material.Material
				},
				{
					name:   "InventoryEvent"
					schema: inventoryEvent.InventoryEvent
				},
			]
	}
}
