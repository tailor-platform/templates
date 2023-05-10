package tailordb

import (
	"github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/protobuf/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:delivery"
	"{{ .Values.cue.package }}/charts/tailordb:product"
	"{{ .Values.cue.package }}/charts/tailordb:order"
	"{{ .Values.cue.package }}/charts/tailordb:location"
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
					name:  "Delivery"
					schema: delivery.Delivery
				},
				{
					name:  "Product"
					schema: product.Product
				},
				{
					name:  "Order"
					schema: order.Order
				},
				{
					name:  "Location"
					schema: location.Location
				},
				]
	}
}
