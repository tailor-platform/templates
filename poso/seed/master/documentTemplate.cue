package master

import (
	"tailor.build/template/seed/utils"
)

#DocumentTemplates: {
	DocumentTemplate1: {
		id: utils.uuid & {_, #type: "documentTemplate", #value: "1"}
		name: "Estimate Template"
	}
	DocumentTemplate2: {
		id: utils.uuid & {_, #type: "documentTemplate", #value: "2"}
		name: "Sales Order Template"
	}
	DocumentTemplate3: {
		id: utils.uuid & {_, #type: "documentTemplate", #value: "3"}
		name: "Invoice Template"
	}
	DocumentTemplate4: {
		id: utils.uuid & {_, #type: "documentTemplate", #value: "4"}
		name: "Purchase Order Template"
	}
	DocumentTemplate5: {
		id: utils.uuid & {_, #type: "documentTemplate", #value: "5"}
		name: "Goods Receiving Note Template"
	}
}

DocumentTemplate: {
	items: [
		for k, v in #DocumentTemplates {
			v
		},
	]
}
