package master

import (
	"tailor.build/template/seed/utils"
)

#Uom: {
	uom0: {
		id: utils.uuid & {_, #type: "uom", #value: "1"}
		name:        "Piece"
		description: "Unit of measurement for counting individual pieces"
	}
	uom1: {
		id: utils.uuid & {_, #type: "uom", #value: "2"}
		name:        "Kilogram"
		description: "Unit of measurement for weight in kilograms"
	}
	uom2: {
		id: utils.uuid & {_, #type: "uom", #value: "3"}
		name:        "Meter"
		description: null
	}
	uom3: {
		id: utils.uuid & {_, #type: "uom", #value: "4"}
		name:        "Hours"
		description: "Measurement of work hours"
	}
	uom4: {
		id: utils.uuid & {_, #type: "uom", #value: "5"}
		name:        "Grams"
		description: null
	}
	uom5: {
		id: utils.uuid & {_, #type: "uom", #value: "6"}
		name:        "Cms"
		description: "Centimeters"
	}
	uom6: {
		id: utils.uuid & {_, #type: "uom", #value: "7"}
		name:        "Minutes"
		description: null
	}
	uom7: {
		id: utils.uuid & {_, #type: "uom", #value: "8"}
		name:        "Foot"
		description: "foot"
	}
}

Uom: {
	items: [
		for k, v in #Uom {
			v
		},
	]
}
