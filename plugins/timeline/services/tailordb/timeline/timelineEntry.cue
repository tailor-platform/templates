package timeline

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/services/tailordb/permissions"
)

TimelineEntry: tailordb.#Type & {
	Name:        "TimelineEntry"
	Description: "Timeline entry related objects connection"
	Settings: {
		BulkUpsert: true
	}
	Fields: {
		sourceID: {
			Type:        tailordb.#TypeUUID
			Description: "The source of the timeline entry"
		}
		sourceType: {
			Type:        tailordb.#TypeString
			Description: "The type of the source"
		}
		eventName: {
			Type:        tailordb.#TypeString
			Description: "The name of the timeline entry"
		}
		eventType: {
			Type:        tailordb.#TypeEnum
			Description: "The event of the timeline entry"
			AllowedValues: [{
				Value:       "activity"
				Description: "Transactions related to the object."
			}, {
				Value:       "note"
				Description: "a note added to the object."
			}, {
				Value:       "correspondence"
				Description: "Emails, messages and phone calls."
			}, {
				Value:       "document"
				Description: "Documents related to the object."
			}, {
				Value:       "changelog"
				Description: "Changes to the object."
			}]
		}
		objectType: {
			Type:        tailordb.#TypeString
			Description: "Type of the object"
		}
		objectID: {
			Type:        tailordb.#TypeUUID
			Description: "ID of the object"
		}
		messageSegments: {
			Type:        tailordb.#TypeNested
			Description: "Message of the object"
			Array:       true
			Fields: {[string]: tailordb.#Field} & {
				text: {
					Type:        tailordb.#TypeString
					Description: "Segment of the message"
				}
				type: {
					Type:        tailordb.#TypeEnum
					Description: "Type of the segment"
					AllowedValues: [
						{
							Value:       "text"
							Description: "Text segment"
						},
						{
							Value:       "link"
							Description: "Link segment"
						},
						{
							Value:       "mention"
							Description: "Mention segment"
						},
						{
							Value:       "date"
							Description: "Date segment"
						},
					]
				}
				linkedObjectType: {
					Type:        tailordb.#TypeString
					Description: "Type of the object"
				}
				linkedObjectID: {
					Type:        tailordb.#TypeUUID
					Description: "ID of the object"
				}
				dateValue: {
					Type:        tailordb.#TypeDateTime
					Description: "Date value"
				}
			}
		}
		createdAt: tailordb.CreatedAtField
	}
	TypePermission: permissions.adminAccess
}
