package pipeline

// ScalarType
#ScalarType: #Type & {
	kind: "ScalarType"
}
#CustomScalarType: #Type & {
	kind: "CustomScalarType"
}

// EnumType
#EnumValue: string & =~"[A-Z_]+"
#EnumType:  #Type & {
	kind: "EnumType"
	values: [...#EnumValue]
}

#Required: #Type & {
	required: true
}

// Scalar
String: #ScalarType & {
	name: "String"
}
Int: #ScalarType & {
	name: "Int"
}
Float: #ScalarType & {
	name: "Float"
}
Boolean: #ScalarType & {
	name: "Boolean"
}
ID: #ScalarType & {
	name: "ID"
}

// Custom Scalar
Date: #CustomScalarType & {
	name: "Date"
}
DateTime: #CustomScalarType & {
	name: "DateTime"
}
Time: #CustomScalarType & {
	name: "Time"
}

// Filter
StringFilter: {
	kind: "FilterType"
	name: "StringFilter"
	fields: [
		{name: "eq", type:       String},
		{name: "ne", type:       String},
		{name: "in", type:       String, array: true},
		{name: "nin", type:      String, array: true},
		{name: "contains", type: String},
		{name: "regex", type:    String},
	]
}

DateFilter: {
	kind: "FilterType"
	name: "DateFilter"
	fields: [
		{name: "lt", type:      Date},
		{name: "in", type:      Date, array: true},
		{name: "eq", type:      Date},
		{name: "gt", type:      Date},
		{name: "ne", type:      Date},
		{name: "nin", type:     Date, array: true},
		{name: "between", type: DateBetweenFilter},
		{name: "gte", type:     Date},
		{name: "lte", type:     Date},
	]
}

DateBetweenFilter: {
	kind: "FilterType"
	name: "DateBetweenFilter"
	fields: [
		{name: "max", type: Date},
		{name: "min", type: Date},
	]
}
