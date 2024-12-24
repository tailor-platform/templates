package master

import (
	"tailor.build/template/seed/utils"
)

#MOBatch: {
	moBatch1: {
		id: utils.uuid & {_, #type: "Mobatch", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "154"}
		name: "Batch 001"
		status: "Planned"                     // Must be one of the allowed enum values
		quantity: 1                         // Quantity to be produced
		batchSize: 1                         // Number of units per batch
	}
}

// MOBatch aggregates all seed entries into a slice for easy access
MOBatch: {
	items: [
		for k, v in #MOBatch {
			v
		},
	]
}
