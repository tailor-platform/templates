package master

import (
	"tailor.build/template/seed/utils"
)

#UomConversion: {
	uomConversion0: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "1"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "2"} // kilogram
		toUomId: utils.uuid & {_, #type: "uom", #value: "5"} // gram
		conversionFactor: 1000
	}
	uomConversion1: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "2"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "3"} // meter
		toUomId: utils.uuid & {_, #type: "uom", #value: "6"} // centimeter
		conversionFactor: 100
	}
	uomConversion2: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "3"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "4"} // hrs
		toUomId: utils.uuid & {_, #type: "uom", #value: "7"} // minutes
		conversionFactor: 60
	}
	uomConversion3: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "4"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "8"} // foot
		toUomId: utils.uuid & {_, #type: "uom", #value: "3"} // meter
		conversionFactor: 0.3048
	}
	uomConversion4: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "5"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "6"} // centimeter
		toUomId: utils.uuid & {_, #type: "uom", #value: "3"} // meter
		conversionFactor: 0.01
	}
	uomConversion5: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "6"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "5"} // gram
		toUomId: utils.uuid & {_, #type: "uom", #value: "2"} // kilogram
		conversionFactor: 0.001
	}
	uomConversion6: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "7"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "7"} // minutes
		toUomId: utils.uuid & {_, #type: "uom", #value: "4"} // hrs
		conversionFactor: 0.0167
	}
	uomConversion7: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "8"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "3"} // meter 
		toUomId: utils.uuid & {_, #type: "uom", #value: "8"} // foot
		conversionFactor: 3.28084
	}
	uomConversion8: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "9"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "6"} // centimeter 
		toUomId: utils.uuid & {_, #type: "uom", #value: "8"} // foot
		conversionFactor:0.0328084
	}
	uomConversion9: {
		id: utils.uuid & {_, #type: "uomconversion", #value: "10"}
		fromUomId: utils.uuid & {_, #type: "uom", #value: "8"} // foot 
		toUomId: utils.uuid & {_, #type: "uom", #value: "6"} // centimeter 
		conversionFactor:30.48
	}
}

UomConversion: {
	items: [
		for k, v in #UomConversion {
			v
		},
	]
}
