package tailordb

#FieldTypeString:   "string"
#FieldTypeText:     "text"
#FieldTypeUUID:     "uuid"
#FieldTypeInteger:  "integer"
#FieldTypeFloat:    "float"
#FieldTypeEnum:     "enum"
#FieldTypeBool:     "boolean"
#FieldTypeDate:     "date"
#FieldTypeTime:     "time"
#FieldTypeDatetime: "datetime"
#FieldTypeNested:   "nested"

#BaseFieldTypeEnum: #FieldTypeString | #FieldTypeText | #FieldTypeUUID | #FieldTypeInteger |
	#FieldTypeFloat | #FieldTypeEnum | #FieldTypeBool | #FieldTypeDate | #FieldTypeTime |
	#FieldTypeDatetime | #FieldTypeNested

#Everyone:     "everyone"
#LoggedInUser: "loggedinUser"
#CreatorUser:  "creatoruser"

#PermitActionEnum:
	#Allow |
	#Skip |
	#Deny

#Allow: 1
#Skip:  2
#Deny:  3

#CreatedAtField: {
	type:        #FieldTypeDatetime
	description: "createdAt"
	index:       true
	hooks: {
		createExpr: "now()"
	}
}
#UpdatedAtField: {
	type:        #FieldTypeDatetime
	description: "updatedAt"
	index:       true
	hooks: {
		updateExpr: "now()"
	}
}
