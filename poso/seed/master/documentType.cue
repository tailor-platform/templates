package master

import (
	"tailor.build/template/seed/utils"
)

#DocumentTypes: {
    DocumentType1: {
        id: utils.uuid & {_, #type: "documentType", #value: "1"},
        name: "Estimate",
		defaultDocumentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "1"},
    },
    DocumentType2: {
        id: utils.uuid & {_, #type: "documentType", #value: "2"},
        name: "Sales Order",
		defaultDocumentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "5"},
    },
    DocumentType3: {
        id: utils.uuid & {_, #type: "documentType", #value: "3"},
        name: "Invoice",
		defaultDocumentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "9"},
    },
    DocumentType4: {
        id: utils.uuid & {_, #type: "documentType", #value: "4"},
        name: "Purchase Order",
		defaultDocumentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "12"},
    },
    DocumentType5: {
        id: utils.uuid & {_, #type: "documentType", #value: "5"},
        name: "Goods Receiving Note",
		defaultDocumentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "17"},
    }
}


DocumentType: {
	items: [
		for k, v in #DocumentTypes {
			v
		},
	]
}
