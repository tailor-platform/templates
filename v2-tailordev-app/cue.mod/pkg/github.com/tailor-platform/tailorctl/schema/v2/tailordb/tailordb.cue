package tailordb

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

#TypeString:   common.#TypeString
#TypeUUID:     common.#TypeUUID
#TypeInt:      common.#TypeInt
#TypeFloat:    common.#TypeFloat
#TypeEnum:     common.#TypeEnum
#TypeBool:     common.#TypeBool
#TypeDate:     common.#TypeDate
#TypeTime:     common.#TypeTime
#TypeDateTime: common.#TypeDateTime
#TypeNested:   "nested"
#FieldType:
	#TypeString | #TypeUUID |
	#TypeInt | #TypeFloat | #TypeEnum | #TypeBool |
	#TypeDate | #TypeTime | #TypeDateTime | #TypeNested

#Expr: "expr"

#Spec: {
	common.#WithVersion
	common.#WithNamespace
	common.#WithKind

	kind: common.#TailorDB
	types: [...#Type]
}

#Type: {
	name:        string & !=""
	description: string | *""
	fields: {[string]: #Field}
	settings: #TypeSetting
	extends:  bool | *false
	directives: [...#Directive]
	indexes: {[string]: #Index}
	typePermission:    #TypePermissions
	recordPermission?: #RecordPermissions
}

#Field: {
	type: string //TODO #FieldType  何らかの制限
	values: [...string]
	description: string | *""
	validate: [...#Validate]
	required:   bool | *false
	array:      bool | *false
	index:      bool | *false
	unique:     bool | *false
	foreignKey: bool | *false
	if foreignKey {
		foreignKeyType?:  string
		foreignKeyField?: string
	}

	fields?: {[string]: #Field} // nested field
	sourceId?: string
	hooks?:    #FieldHook
}

#FieldHook: {
	createExpr: string | *null
	updateExpr: string | *null
}

#TypeSetting: {
	versioning:            bool | *false
	aggregation:           bool | *false
	bulkUpsert:            bool | *false
	defaultQueryLimitSize: int | *100
	maxBulkUpsertSize:     int | *1000
}

#Directive: {
	name: string & !=""
	args: [...{name: string, value: string}]
}

#Index: {
	fieldNames: [...string]
	unique: bool | *false
}

#TypePermissions: {
	create: [...#Permission]
	read: [...#Permission]
	update: [...#Permission]
	delete: [...#Permission]
	admin: [...#Permission]
}

#RecordPermissions: {
	create: [...#Permission]
	read: [...#Permission]
	update: [...#Permission]
	delete: [...#Permission]
	admin: [...#Permission]
}

#Permission: {
	id:     string | #Everyone | #LoggedInUser | #CreatorUser
	permit: #Permit.Unspecified | #Permit.Allow | #Permit.Skip | #Permit.Deny
}

#Everyone:     "everyone"
#LoggedInUser: "loggedinUser"
#CreatorUser:  "creatoruser"

#Permit: {
	Unspecified: "unspecified"
	Allow:       "allow"
	Skip:        "skip"
	Deny:        "deny"
}

#Validate: {
	expr:          string
	action:        #Permit.UNSPECIFIED | #Permit.ALLOW | #Permit.SKIP | #Permit.DENY
	errorMessage?: string
}

CreatedAtField: #Field & {
	type:        #TypeDateTime
	description: "createdAt"
	index:       true
	hooks: {
		createExpr: "now()"
	}
}

UpdatedAtField: #Field & {
	type:        #TypeDateTime
	description: "updatedAt"
	index:       true
	hooks: {
		updateExpr: "now()"
	}
}
