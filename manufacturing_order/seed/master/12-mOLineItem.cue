package master

import (
	"tailor.build/template/seed/utils"
)

#MOLineItem: {
	// Manufacturing Order Line Items for Honda Motorcycle C125A 2AC
	mOLineItem0: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "0"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "144"} // Abs Modulator
		requiredQuantity: 1
		totalCost: 860.38
	}
	mOLineItem1: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "1"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "145"} // Air Cleaner
		requiredQuantity: 1
		totalCost: 85.79
	}
	mOLineItem2: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "2"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "146"} // Alternator
		requiredQuantity: 1
		totalCost: 88.71
	}
	mOLineItem3: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "3"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "147"} // Battery
		requiredQuantity: 1
		totalCost: 120.00
	}
	mOLineItem4: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "4"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "148"} // Body / Cover
		requiredQuantity: 1
		totalCost: 350.00
	}
	mOLineItem5: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "5"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "149"} // Cam Chain Tensioner
		requiredQuantity: 1
		totalCost: 45.00
	}
	mOLineItem6: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "6"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "150"} // Camshaft-Valve
		requiredQuantity: 1
		totalCost: 75.00
	}
	mOLineItem7: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "7"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "151"} // Canister
		requiredQuantity: 1
		totalCost: 25.00
	}
	mOLineItem8: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "8"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "152"} // Caution Labels
		requiredQuantity: 1
		totalCost: 2.50
	}
	mOLineItem9: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "9"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "153"} // Clutch
		requiredQuantity: 1
		totalCost: 200.00
	}
	mOLineItem10: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "10"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "154"} // Crankcase
		requiredQuantity: 1
		totalCost: 400.00
	}
	mOLineItem11: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "11"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "155"} // Crankshaft Piston
		requiredQuantity: 1
		totalCost: 60.00
	}
	mOLineItem12: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "12"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "156"} // Cylinder
		requiredQuantity: 1
		totalCost: 150.00
	}
	mOLineItem13: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "13"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "157"} // Cylinder Head
		requiredQuantity: 1
		totalCost: 250.00
	}
	mOLineItem14: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "14"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "158"} // Frame
		requiredQuantity: 1
		totalCost: 1200.00
	}
	mOLineItem15: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "15"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "159"} // Front Brake Master Cylinder
		requiredQuantity: 1
		totalCost: 75.00
	}
	mOLineItem16: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "16"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "160"} // Front Brake-Caliper
		requiredQuantity: 1
		totalCost: 150.00
	}
	mOLineItem17: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "17"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "161"} // Front Cover / Leg Shield
		requiredQuantity: 1
		totalCost: 50.00
	}
	mOLineItem18: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "18"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "162"} // Front Fender
		requiredQuantity: 1
		totalCost: 535.27
	}
	mOLineItem19: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "19"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "163"} // Rear Fender
		requiredQuantity: 1
		totalCost: 718.65
	}
	mOLineItem20: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "20"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "164"} // Front Fork
		requiredQuantity: 1
		totalCost: 521.65
	}
	mOLineItem21: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "21"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "165"} // Rear Shock Absorber
		requiredQuantity: 1
		totalCost: 342.68
	}
	mOLineItem22: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "22"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "166"} // Front Wheel
		requiredQuantity: 1
		totalCost: 467.00
	}
	mOLineItem23: {
		id: utils.uuid & {_, #type: "MOLineItem", #value: "23"}
		moId: utils.uuid & {_, #type: "ManufacturingOrder", #value: "1"}
		bomLineItemId: utils.uuid & {_, #type: "bomlineitem", #value: "167"} // Rear Wheel
		requiredQuantity: 1
		totalCost: 565.74
	}
}

MOLineItem: {
	items: [
		for k, v in #MOLineItem {
			v
		},
	]
}
