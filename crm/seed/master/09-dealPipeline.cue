package master

import (
	"tailor.build/template/seed/utils"
)

#DealPipeline: {
	dealPipeline0: {
		id: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 1
		label:        "Sales Development Representative Pipeline"
	}
	dealPipeline1: {
		id: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 2
		label:        "Sales Qualified Lead to Estimate Pipeline"
	}
	dealPipeline3: {
		id: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 3
		label:        "Estimate to Closing Pipeline"
	}
}

DealPipeline: {
	items: [
		for k, v in #DealPipeline {
			v
		},
	]
}
