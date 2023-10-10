package location

import (
	"tailor.build/scm-adv/charts/common:permissions"
	"github.com/tailor-inc/platform-core-services/cmd/tailorctl/schema/v1:tailordb"
	"github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"
)

_fields: {[string]: tailordbv1.#FieldConfig} & {
	"locationName": {
		type:        tailordb.#FieldTypeString
		description: "Location name"
	}
	"locationCode": {
		type:        tailordb.#FieldTypeInteger
		description: "Location code"
	}
	"city": {
		type:        tailordb.#FieldTypeString
		description: "City"
	}
	"country": {
		type:        tailordb.#FieldTypeString
		description: "Country"
	}
	"address1": {
		type:        tailordb.#FieldTypeString
		description: "Address1"
	}
	"address2": {
		type:        tailordb.#FieldTypeString
		description: "Address2"
	}
	"zipcode": {
		type:        tailordb.#FieldTypeString
		description: "Zipcode"
	}

}

Location: tailordbv1.#TypeConfig & {
	fields:      _fields
	description: "Location model"
	permission:  permissions.employee
}
