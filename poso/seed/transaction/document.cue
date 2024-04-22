package transaction

import (
	"tailor.build/template/seed/utils"
)

#Documents: {
    Document1: {
        id: utils.uuid & {_, #type: "document", #value: "1"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "1"},
        contactID: utils.uuid & {_, #type: "contact", #value: "1"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "1"},
        code: "EST-00001",
        date: "2023-12-01"
    },
    Document2: {
        id: utils.uuid & {_, #type: "document", #value: "2"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "5"},
        contactID: utils.uuid & {_, #type: "contact", #value: "1"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "2"},
        code: "SO-00001",
        date: "2023-12-02"
    },
    Document3: {
        id: utils.uuid & {_, #type: "document", #value: "3"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "3"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "9"},
        contactID: utils.uuid & {_, #type: "contact", #value: "1"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "3"},
        code: "INV-00001",
        date: "2023-12-15",
        paymentAmount: 0,
        paymentDueDate: "2023-12-17"
    },
    Document4: {
        id: utils.uuid & {_, #type: "document", #value: "4"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "4"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "12"},
        contactID: utils.uuid & {_, #type: "contact", #value: "1"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "4"},
        status: "POCOMPLETED",
        code: "PO-00001",
        date: "2023-12-03"
    },
    Document5: {
        id: utils.uuid & {_, #type: "document", #value: "5"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "5"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "18"},
        contactID: utils.uuid & {_, #type: "contact", #value: "1"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "5"},
        status: "GRNPAID",
        code: "GRN-00001",
        date: "2023-12-07"
    },
    Document6: {
        id: utils.uuid & {_, #type: "document", #value: "6"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "1"},
        contactID: utils.uuid & {_, #type: "contact", #value: "2"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "1"},
        code: "EST-00002",
        date: "2023-12-03"
    },
    Document7: {
        id: utils.uuid & {_, #type: "document", #value: "7"},
        documentTypeID: utils.uuid & {_, #type: "documentType", #value: "2"},
        documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "7"},
        contactID: utils.uuid & {_, #type: "contact", #value: "2"},
        documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "2"},
        code: "SO-00002",
        date: "2023-12-04"
    },
    Document8: {
		id: utils.uuid & {_, #type: "document", #value: "8"},
		documentTypeID: utils.uuid & {_, #type: "documentType", #value: "1"},
		contactID: utils.uuid & {_, #type: "contact", #value: "2"},
		documentTemplateID: utils.uuid & {_, #type: "documentTemplate", #value: "1"},
		documentStatusID: utils.uuid & {_, #type: "documentStatus", #value: "2"},
		code: "EST-00003",
		date: "2024-01-01"
	},
}


Document: {
	items: [
		for k, v in #Documents {
			id:       v.id
            documentTypeID: v.documentTypeID
            contactID: v.contactID
            documentStatusID: v.documentStatusID
            documentTemplateID: v.documentTemplateID
            code: v.code
            date: v.date
            if v.paymentAmount != _|_ { paymentAmount: v.paymentAmount }
            if v.paymentDueDate != _|_ { paymentDueDate: v.paymentDueDate }
            isCalculated: true
		},
	]
}