package master

import (
	"tailor.build/template/seed/utils"
)

#DocumentStatuses: {
	documentStatus1: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "1"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"}
		name:               "draft"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "2"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "4"}
			},
		]
	}
	documentStatus2: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "2"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"}
		name:               "sent"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "3"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "4"}
			},
		]
	}
	documentStatus3: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "3"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"}
		name:               "approved"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "4"}
			},
		]
	}
	documentStatus4: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "4"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"}
		name:               "closed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
	documentStatus5: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "5"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"}
		name:               "draft"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "6"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "8"}
			},
		]
	}
	documentStatus6: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "6"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"}
		name:               "open"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "7"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "8"}
			},
		]
	}
	documentStatus7: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "7"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"}
		name:               "completed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: true
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "8"}
			},
		]
	}
	documentStatus8: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "8"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"}
		name:               "closed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
	documentStatus9: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "9"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "3"}
		name:               "draft"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "10"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "11"}
			},

		]
	}
	documentStatus10: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "10"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "3"}
		name:               "pushed to QB"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
	documentStatus11: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "11"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "3"}
		name:               "deleted"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
	documentStatus12: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "12"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"}
		name:               "draft"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "13"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "16"}
			},
		]
	}
	documentStatus13: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "13"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"}
		name:               "sent"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "14"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "16"}
			},
		]
	}
	documentStatus14: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "14"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"}
		name:               "acknowledged"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "15"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "16"}
			},
		]
	}
	documentStatus15: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "15"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"}
		name:               "completed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "16"}
			},
		]
	}
	documentStatus16: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "16"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"}
		name:               "closed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
	documentStatus17: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "17"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "5"}
		name:               "receiving"
		isEditable:         true
		inactive:           false
		triggersStockEvent: false
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "18"}
			},
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "19"}
			},
		]
	}
	documentStatus18: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "18"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "5"}
		name:               "received"
		isEditable:         true
		inactive:           false
		triggersStockEvent: true
		toStates: [
			{
				documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "19"}
			},
		]
	}
	documentStatus19: {
		id: utils.uuid & {_, #type: "documentStatus", #value: "19"}
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "5"}
		name:               "closed"
		isEditable:         false
		inactive:           false
		triggersStockEvent: false
		toStates: []
	}
}

DocumentStatus: {
	items: [
		for k, v in #DocumentStatuses {
			v
		},
	]
}
