package master

import (
	"tailor.build/template/seed/utils"
)

#BomLineItem: {
	bomLineItem0: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "1"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "19"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.61
	}

	bomLineItem1: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "2"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "20"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 17.44
	}

	bomLineItem2: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "3"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "21"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 18.07
	}

	bomLineItem3: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "4"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "22"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 4.56
	}

	bomLineItem4: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "5"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "22"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.75
	}

	bomLineItem5: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "6"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "23"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 15.2
	}

	bomLineItem6: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "7"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "24"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 785.84
	}

	bomLineItem7: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "8"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "25"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem8: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "9"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "26"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.03
	}

	bomLineItem9: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "10"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "27"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.05
	}

	bomLineItem10: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "11"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "28"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.21
	}

	bomLineItem11: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "12"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "29"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2
	}

	bomLineItem12: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "13"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "30"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.92
	}

	bomLineItem13: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "14"}
		bomId: utils.uuid & {_, #type: "bom", #value: "1"}
		itemId: utils.uuid & {_, #type: "item", #value: "31"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.49
	}

	bomLineItem14: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "15"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "33"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.69
	}

	bomLineItem15: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "16"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "34"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 55.11
	}

	bomLineItem16: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "17"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "35"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 74.34
	}

	bomLineItem17: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "18"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "36"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 59.66
	}

	bomLineItem18: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "19"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "37"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.67
	}

	bomLineItem19: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "20"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "38"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 114.61
	}

	bomLineItem20: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "21"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "39"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.67
	}

	bomLineItem21: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "22"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "40"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 118.87
	}

	bomLineItem22: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "23"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "41"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 53.03
	}

	bomLineItem23: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "24"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "42"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem24: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "25"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "43"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.11
	}

	bomLineItem25: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "26"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "44"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.2
	}

	bomLineItem26: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "27"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "45"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem27: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "28"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "46"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.03
	}

	bomLineItem28: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "29"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "47"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.23
	}

	bomLineItem29: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "30"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "48"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.03
	}

	bomLineItem30: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "31"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "49"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.11
	}

	bomLineItem31: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "32"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "50"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.74
	}

	bomLineItem32: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "33"}
		bomId: utils.uuid & {_, #type: "bom", #value: "19"}
		itemId: utils.uuid & {_, #type: "item", #value: "51"}
		inputQuantity: 5
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.66
	}

	bomLineItem33: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "34"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "53"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 22.34
	}

	bomLineItem34: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "35"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "54"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.67
	}

	bomLineItem35: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "36"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "25"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem36: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "37"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "55"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 393.79
	}

	bomLineItem37: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "38"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "56"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 20.31
	}

	bomLineItem38: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "39"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "57"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.89
	}

	bomLineItem39: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "40"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "58"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 4.38
	}

	bomLineItem40: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "41"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "59"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 185.18
	}

	bomLineItem41: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "42"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "60"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.15
	}

	bomLineItem42: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "43"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "61"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.74
	}

	bomLineItem43: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "44"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "62"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.9
	}

	bomLineItem44: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "45"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "63"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 5.43
	}

	bomLineItem45: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "46"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "44"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.2
	}

	bomLineItem46: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "47"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "64"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.56
	}

	bomLineItem47: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "48"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "45"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem48: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "49"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "28"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.21
	}

	bomLineItem49: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "50"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "65"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.75
	}

	bomLineItem50: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "51"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "66"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.82
	}

	bomLineItem51: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "52"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "67"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.67
	}

	bomLineItem52: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "53"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "67"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.67
	}

	bomLineItem53: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "54"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "67"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.67
	}

	bomLineItem54: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "55"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "67"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.67
	}

	bomLineItem55: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "56"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "68"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.85
	}

	bomLineItem56: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "57"}
		bomId: utils.uuid & {_, #type: "bom", #value: "20"}
		itemId: utils.uuid & {_, #type: "item", #value: "69"}
		inputQuantity: 5
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.54
	}

	bomLineItem57: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "58"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "70"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.41
	}

	bomLineItem58: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "59"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "71"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.9
	}

	bomLineItem59: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "60"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "72"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.23
	}

	bomLineItem60: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "61"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "73"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.05
	}

	bomLineItem61: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "62"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "74"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 11.46
	}

	bomLineItem62: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "63"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "75"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.41
	}

	bomLineItem63: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "64"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "76"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.95
	}

	bomLineItem64: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "65"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "77"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.03
	}

	bomLineItem65: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "66"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "78"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 19.74
	}

	bomLineItem66: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "67"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "79"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.52
	}

	bomLineItem67: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "68"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "62"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.9
	}

	bomLineItem68: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "69"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "80"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 4.56
	}

	bomLineItem69: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "70"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "81"}
		inputQuantity: 5
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.02
	}

	bomLineItem70: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "71"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "82"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.03
	}

	bomLineItem71: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "72"}
		bomId: utils.uuid & {_, #type: "bom", #value: "2"}
		itemId: utils.uuid & {_, #type: "item", #value: "83"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.38
	}

	bomLineItem72: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "73"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "85"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 54.36
	}

	bomLineItem73: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "74"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "86"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 111.16
	}

	bomLineItem74: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "75"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "87"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.21
	}

	bomLineItem75: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "76"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "88"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 35.72
	}

	bomLineItem76: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "77"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "89"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 4.21
	}

	bomLineItem77: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "78"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "90"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.49
	}

	bomLineItem78: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "79"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "91"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 54.1
	}

	bomLineItem79: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "80"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "92"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 14.13
	}

	bomLineItem80: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "81"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "93"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.26
	}

	bomLineItem81: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "82"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "94"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.38
	}

	bomLineItem82: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "83"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "95"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.36
	}

	bomLineItem83: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "84"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "96"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.93
	}

	bomLineItem84: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "85"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "97"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.72
	}

	bomLineItem85: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "86"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "98"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 5.51
	}

	bomLineItem86: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "87"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "99"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 97.28
	}

	bomLineItem87: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "88"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "100"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 23.03
	}

	bomLineItem88: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "89"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "101"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.3
	}

	bomLineItem89: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "90"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "102"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.82
	}

	bomLineItem90: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "91"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "103"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.54
	}

	bomLineItem91: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "92"}
		bomId: utils.uuid & {_, #type: "bom", #value: "21"}
		itemId: utils.uuid & {_, #type: "item", #value: "104"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.13
	}

	bomLineItem92: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "93"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "106"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 141.9
	}

	bomLineItem93: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "94"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "107"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.18
	}

	bomLineItem94: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "95"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "108"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 5.18
	}

	bomLineItem95: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "96"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "109"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 6.33
	}

	bomLineItem96: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "97"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "110"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.1
	}

	bomLineItem97: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "98"}
		bomId: utils.uuid & {_, #type: "bom", #value: "22"}
		itemId: utils.uuid & {_, #type: "item", #value: "111"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.48
	}

	bomLineItem98: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "99"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "112"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 51.48
	}

	bomLineItem99: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "100"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "113"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 30.31
	}

	bomLineItem100: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "101"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "114"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.84
	}

	bomLineItem101: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "102"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "115"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.92
	}

	bomLineItem102: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "103"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "116"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.93
	}

	bomLineItem103: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "104"}
		bomId: utils.uuid & {_, #type: "bom", #value: "3"}
		itemId: utils.uuid & {_, #type: "item", #value: "31"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.1
	}

	bomLineItem104: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "105"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "118"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.21
	}

	bomLineItem105: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "106"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "119"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 6.79
	}

	bomLineItem106: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "107"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "120"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.56
	}

	bomLineItem107: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "108"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "121"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 23.89
	}

	bomLineItem108: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "109"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "122"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 6.77
	}

	bomLineItem109: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "110"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "123"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 266.75
	}

	bomLineItem110: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "111"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "124"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 44.39
	}

	bomLineItem111: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "112"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "125"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 65.75
	}

	bomLineItem112: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "113"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "126"}
		inputQuantity: 5
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.61
	}

	bomLineItem113: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "114"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "127"}
		inputQuantity: 3
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.93
	}

	bomLineItem114: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "115"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "128"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.77
	}

	bomLineItem115: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "116"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "129"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.74
	}

	bomLineItem116: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "117"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "130"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.92
	}

	bomLineItem117: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "118"}
		bomId: utils.uuid & {_, #type: "bom", #value: "23"}
		itemId: utils.uuid & {_, #type: "item", #value: "131"}
		inputQuantity: 2
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.2
	}

	bomLineItem118: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "119"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "133"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 9.48
	}

	bomLineItem119: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "120"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "134"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 9.48
	}

	bomLineItem120: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "121"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "135"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 20.97
	}

	bomLineItem121: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "122"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "136"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 5.84
	}

	bomLineItem122: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "123"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "137"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 7.52
	}

	bomLineItem123: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "124"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "138"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 64.18
	}

	bomLineItem124: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "125"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "139"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 4.52
	}

	bomLineItem125: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "126"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "140"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 286.36
	}

	bomLineItem126: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "127"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "141"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.13
	}

	bomLineItem127: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "128"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "142"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 54.62
	}

	bomLineItem128: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "129"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "118"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.21
	}

	bomLineItem129: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "130"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "119"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 10.38
	}

	bomLineItem130: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "131"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "143"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.61
	}

	bomLineItem131: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "132"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "144"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.11
	}

	bomLineItem132: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "133"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "145"}
		inputQuantity: 4
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.43
	}

	bomLineItem133: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "134"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "146"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.43
	}

	bomLineItem134: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "135"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "147"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 10.57
	}

	bomLineItem135: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "136"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "148"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 18.3
	}

	bomLineItem136: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "137"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "149"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 18.3
	}

	bomLineItem137: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "138"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "129"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.74
	}

	bomLineItem138: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "139"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "130"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 3.92
	}

	bomLineItem139: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "140"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "150"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 6.36
	}

	bomLineItem140: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "141"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "151"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 8.07
	}

	bomLineItem141: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "142"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "152"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 0.87
	}

	bomLineItem142: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "143"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "153"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.21
	}

	bomLineItem143: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "144"}
		bomId: utils.uuid & {_, #type: "bom", #value: "24"}
		itemId: utils.uuid & {_, #type: "item", #value: "153"}
		inputQuantity: 1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1.21
	}

	bomLineItem144: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "144"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "1"} // Abs Modulator
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 860.38
	}

	bomLineItem145: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "145"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "2"} // Air Cleaner
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 85.79
	}

	bomLineItem146: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "146"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "3"} // Alternator
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 88.71
	}

	bomLineItem147: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "147"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "4"} // Battery
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 120.00
	}

	bomLineItem148: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "148"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "5"} // Body / Cover
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 350.00
	}

	bomLineItem149: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "149"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "6"} // Cam Chain Tensioner
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 45.00
	}

	bomLineItem150: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "150"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "7"} // Camshaft-Valve
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 75.00
	}

	bomLineItem151: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "151"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "8"} // Canister
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 25.00
	}

	bomLineItem152: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "152"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "9"} // Caution Labels
		inputQuantity:                                       1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 2.50
	}

	bomLineItem153: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "153"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "10"} // Clutch
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 200.00
	}

	bomLineItem154: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "154"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "11"} // Crankcase
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 400.00
	}

	bomLineItem155: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "155"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "12"} // Crankshaft Piston
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 60.00
	}

	bomLineItem156: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "156"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "13"} // Cylinder
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 150.00
	}

	bomLineItem157: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "157"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "14"} // Cylinder Head
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 250.00
	}

	bomLineItem158: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "158"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "15"} // Frame
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 1200.00
	}

	bomLineItem159: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "159"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "16"} // Front Brake Master Cylinder
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 75.00
	}

	bomLineItem160: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "160"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "17"} // Front Brake-Caliper
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 150.00
	}

	bomLineItem161: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "161"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "18"} // Front Cover / Leg Shield
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 50.00
	}

	bomLineItem162: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "162"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "32"} // Front Fender
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 535.27
	}

	bomLineItem163: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "163"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "52"} // Rear Fender
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 718.65
	}

	bomLineItem164: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "164"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "84"} // Front Fork
		inputQuantity:                                        1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 521.65
	}

	bomLineItem165: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "165"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "105"} // Rear Shock Absorber
		inputQuantity:                                         1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 342.68
	}

	bomLineItem166: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "166"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "117"} // Front Wheel
		inputQuantity:                                         1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 467.00
	}

	bomLineItem167: {
		id: utils.uuid & {_, #type: "bomlineitem", #value: "167"}
		bomId: utils.uuid & {_, #type: "bom", #value: "25"}
		itemId: utils.uuid & {_, #type: "item", #value: "132"} // Rear Wheel
		inputQuantity:                                         1
		uomId: utils.uuid & {_, #type: "uom", #value: "1"}
		unitCost: 565.74
	}

}

BomLineItem: {
	items: [
		for k, v in #BomLineItem {
			v
		},
	]
}
