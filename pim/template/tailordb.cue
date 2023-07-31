package tailordb

import (
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:manifest"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
	"{{ .Values.cue.package }}/charts/tailordb:attribute"
	"{{ .Values.cue.package }}/charts/tailordb:brand"
	"{{ .Values.cue.package }}/charts/tailordb:brandUser"
	"{{ .Values.cue.package }}/charts/tailordb:category"
	"{{ .Values.cue.package }}/charts/tailordb:product"
	"{{ .Values.cue.package }}/charts/tailordb:user"
	
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
					name:   "Attribute"
					schema: attribute.Attribute
				},
				{
					name:   "Brand"
					schema: brand.Brand
				},
				{
					name:   "BrandUser"
					schema: brandUser.BrandUser
				},
				{
					name:   "Category"
					schema: category.Category
				},
				{
					name:   "Product"
					schema: product.Product
				},
				{
					name:   "User"
					schema: user.User
				},
			]
	}
}
