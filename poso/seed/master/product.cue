package master

import (
	"tailor.build/template/seed/utils"
)

#Products: {
	Product1: {
		id: utils.uuid & {_, #type: "product", #value: "1"}
		name:          "Balance of System (BOS)"
		unitCost:      0
		unitPrice:     0
		costCategory:  "Equipment"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "1"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product2: {
		id: utils.uuid & {_, #type: "product", #value: "2"}
		name:          "Solar Panel"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "2"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product3: {
		id: utils.uuid & {_, #type: "product", #value: "3"}
		name:          "Mounting Brackets"
		unitCost:      30
		unitPrice:     45
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product4: {
		id: utils.uuid & {_, #type: "product", #value: "4"}
		name:          "Inverter"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "2"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product5: {
		id: utils.uuid & {_, #type: "product", #value: "5"}
		name:          "Wiring"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Feet"
		recalculatedLineItem: false
	}
	Product6: {
		id: utils.uuid & {_, #type: "product", #value: "6"}
		name:          "Installation Labor"
		unitCost:      50
		unitPrice:     75
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "1"}
		uom:                  "Hours"
		recalculatedLineItem: false
	}
	Product7: {
		id: utils.uuid & {_, #type: "product", #value: "7"}
		name:          "Project Consultation"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "1"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product8: {
		id: utils.uuid & {_, #type: "product", #value: "8"}
		name:          "Safety Equipment"
		unitCost:      40
		unitPrice:     60
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product9: {
		id: utils.uuid & {_, #type: "product", #value: "9"}
		name:          "Inspection Fee"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "2"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product10: {
		id: utils.uuid & {_, #type: "product", #value: "10"}
		name:          "Transport Charges"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "2"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product11: {
		id: utils.uuid & {_, #type: "product", #value: "11"}
		name:          "Large Lithium-ion battery"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "1"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product12: {
		id: utils.uuid & {_, #type: "product", #value: "12"}
		name:          "Solar Microinverters"
		unitCost:      120
		unitPrice:     180
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product13: {
		id: utils.uuid & {_, #type: "product", #value: "13"}
		name:          "DC to AC Power Converters"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product14: {
		id: utils.uuid & {_, #type: "product", #value: "14"}
		name:          "Solar Charge Controllers"
		unitCost:      80
		unitPrice:     120
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product15: {
		id: utils.uuid & {_, #type: "product", #value: "15"}
		name:          "Energy Storage Systems"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product16: {
		id: utils.uuid & {_, #type: "product", #value: "16"}
		name:          "Grid Tie Inverters"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product17: {
		id: utils.uuid & {_, #type: "product", #value: "17"}
		name:          "Solar Panel Frames"
		unitCost:      75
		unitPrice:     112.5
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product18: {
		id: utils.uuid & {_, #type: "product", #value: "18"}
		name:          "Ground Mounting Systems"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product19: {
		id: utils.uuid & {_, #type: "product", #value: "19"}
		name:          "Roof Anchors"
		unitCost:      25
		unitPrice:     37.5
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product20: {
		id: utils.uuid & {_, #type: "product", #value: "20"}
		name:          "Cable Management Clips"
		unitCost:      5
		unitPrice:     7.5
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product21: {
		id: utils.uuid & {_, #type: "product", #value: "21"}
		name:          "Solar Tracker Systems"
		unitCost:      400
		unitPrice:     600
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product22: {
		id: utils.uuid & {_, #type: "product", #value: "22"}
		name:          "AC Disconnect Switches"
		unitCost:      60
		unitPrice:     90
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product23: {
		id: utils.uuid & {_, #type: "product", #value: "23"}
		name:          "Solar Combiner Boxes"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product24: {
		id: utils.uuid & {_, #type: "product", #value: "24"}
		name:          "Circuit Breakers"
		unitCost:      30
		unitPrice:     45
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product25: {
		id: utils.uuid & {_, #type: "product", #value: "25"}
		name:          "Surge Protection Devices"
		unitCost:      40
		unitPrice:     60
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product26: {
		id: utils.uuid & {_, #type: "product", #value: "26"}
		name:          "Battery Cables and Connectors"
		unitCost:      20
		unitPrice:     30
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product27: {
		id: utils.uuid & {_, #type: "product", #value: "27"}
		name:          "System Design Consultation"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product28: {
		id: utils.uuid & {_, #type: "product", #value: "28"}
		name:          "Permit Acquisition Assistance"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product29: {
		id: utils.uuid & {_, #type: "product", #value: "29"}
		name:          "Maintenance and Repair Services"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product30: {
		id: utils.uuid & {_, #type: "product", #value: "30"}
		name:          "Performance Monitoring Setup"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product31: {
		id: utils.uuid & {_, #type: "product", #value: "31"}
		name:          "Renewable Energy Credit Registration"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product32: {
		id: utils.uuid & {_, #type: "product", #value: "32"}
		name:          "Electrical Safety Gloves"
		unitCost:      10
		unitPrice:     15
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product33: {
		id: utils.uuid & {_, #type: "product", #value: "33"}
		name:          "Solar Panel Cleaning Kits"
		unitCost:      50
		unitPrice:     75
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product34: {
		id: utils.uuid & {_, #type: "product", #value: "34"}
		name:          "Fall Protection Harnesses"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product35: {
		id: utils.uuid & {_, #type: "product", #value: "35"}
		name:          "First Aid Kits"
		unitCost:      25
		unitPrice:     37.5
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product36: {
		id: utils.uuid & {_, #type: "product", #value: "36"}
		name:          "Fire Extinguishers"
		unitCost:      30
		unitPrice:     45
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product37: {
		id: utils.uuid & {_, #type: "product", #value: "37"}
		name:          "Secure Storage Solutions"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product38: {
		id: utils.uuid & {_, #type: "product", #value: "38"}
		name:          "Custom Crate Packaging"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product39: {
		id: utils.uuid & {_, #type: "product", #value: "39"}
		name:          "Heavy Equipment Rental"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product40: {
		id: utils.uuid & {_, #type: "product", #value: "40"}
		name:          "On-site Delivery Services"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product41: {
		id: utils.uuid & {_, #type: "product", #value: "41"}
		name:          "Logistics Coordination Service"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product42: {
		id: utils.uuid & {_, #type: "product", #value: "42"}
		name:          "Solar PV Design Software Subscription"
		unitCost:      1000
		unitPrice:     1500
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product43: {
		id: utils.uuid & {_, #type: "product", #value: "43"}
		name:          "Energy Analysis Software License"
		unitCost:      800
		unitPrice:     1200
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product44: {
		id: utils.uuid & {_, #type: "product", #value: "44"}
		name:          "CRM Software"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product45: {
		id: utils.uuid & {_, #type: "product", #value: "45"}
		name:          "Project Management Software Licenses"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product46: {
		id: utils.uuid & {_, #type: "product", #value: "46"}
		name:          "Inventory Management System Access"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product47: {
		id: utils.uuid & {_, #type: "product", #value: "47"}
		name:          "PV Module Cleaning Robot"
		unitCost:      1500
		unitPrice:     2250
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product48: {
		id: utils.uuid & {_, #type: "product", #value: "48"}
		name:          "Smart Solar Monitoring Device"
		unitCost:      350
		unitPrice:     525
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product49: {
		id: utils.uuid & {_, #type: "product", #value: "49"}
		name:          "Anti-Theft Solar Panel Locks"
		unitCost:      45
		unitPrice:     67.5
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product50: {
		id: utils.uuid & {_, #type: "product", #value: "50"}
		name:          "Solar PV Test Kit"
		unitCost:      220
		unitPrice:     330
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product51: {
		id: utils.uuid & {_, #type: "product", #value: "51"}
		name:          "Adjustable Tilt Solar Mount"
		unitCost:      180
		unitPrice:     270
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product52: {
		id: utils.uuid & {_, #type: "product", #value: "52"}
		name:          "Solar Water Pumping System"
		unitCost:      750
		unitPrice:     1125
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product53: {
		id: utils.uuid & {_, #type: "product", #value: "53"}
		name:          "Photovoltaic (PV) Metre"
		unitCost:      100
		unitPrice:     150
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product54: {
		id: utils.uuid & {_, #type: "product", #value: "54"}
		name:          "Wireless Solar Data Logger"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product55: {
		id: utils.uuid & {_, #type: "product", #value: "55"}
		name:          "Solar Irradiance Meter"
		unitCost:      120
		unitPrice:     180
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product56: {
		id: utils.uuid & {_, #type: "product", #value: "56"}
		name:          "Dual-axis Solar Tracker"
		unitCost:      600
		unitPrice:     900
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product57: {
		id: utils.uuid & {_, #type: "product", #value: "57"}
		name:          "Solar Panel Anti-reflective Coating"
		unitCost:      400
		unitPrice:     600
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product58: {
		id: utils.uuid & {_, #type: "product", #value: "58"}
		name:          "PV System Disconnect Switch"
		unitCost:      70
		unitPrice:     105
		costCategory:  "Electrical"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product59: {
		id: utils.uuid & {_, #type: "product", #value: "59"}
		name:          "Solar Pathway Lighting"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product60: {
		id: utils.uuid & {_, #type: "product", #value: "60"}
		name:          "Solar Powered Security Camera"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product61: {
		id: utils.uuid & {_, #type: "product", #value: "61"}
		name:          "Portable Solar Generator"
		unitCost:      450
		unitPrice:     675
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product62: {
		id: utils.uuid & {_, #type: "product", #value: "62"}
		name:          "Solar Thermal Collector"
		unitCost:      550
		unitPrice:     825
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product63: {
		id: utils.uuid & {_, #type: "product", #value: "63"}
		name:          "Solar Ventilation Fan"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product64: {
		id: utils.uuid & {_, #type: "product", #value: "64"}
		name:          "Solar Panel Bird Deterrent"
		unitCost:      60
		unitPrice:     90
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product65: {
		id: utils.uuid & {_, #type: "product", #value: "65"}
		name:          "Wireless Solar Monitoring System"
		unitCost:      320
		unitPrice:     480
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product66: {
		id: utils.uuid & {_, #type: "product", #value: "66"}
		name:          "Off-grid Solar System Design"
		unitCost:      400
		unitPrice:     600
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product67: {
		id: utils.uuid & {_, #type: "product", #value: "67"}
		name:          "Solar Finance Consultation"
		unitCost:      210
		unitPrice:     315
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product68: {
		id: utils.uuid & {_, #type: "product", #value: "68"}
		name:          "Solar Compliance and Certification"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product69: {
		id: utils.uuid & {_, #type: "product", #value: "69"}
		name:          "Emergency Solar Power Solution"
		unitCost:      1000
		unitPrice:     1500
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product70: {
		id: utils.uuid & {_, #type: "product", #value: "70"}
		name:          "Solar Project Feasibility Study"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product71: {
		id: utils.uuid & {_, #type: "product", #value: "71"}
		name:          "Solar Installation Training Course"
		unitCost:      800
		unitPrice:     1200
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product72: {
		id: utils.uuid & {_, #type: "product", #value: "72"}
		name:          "High Visibility Safety Vest"
		unitCost:      20
		unitPrice:     30
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product73: {
		id: utils.uuid & {_, #type: "product", #value: "73"}
		name:          "Solar Installation Safety Manual"
		unitCost:      40
		unitPrice:     60
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product74: {
		id: utils.uuid & {_, #type: "product", #value: "74"}
		name:          "Emergency Response Plan"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product75: {
		id: utils.uuid & {_, #type: "product", #value: "75"}
		name:          "Safety Signage for Solar Sites"
		unitCost:      10
		unitPrice:     15
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product76: {
		id: utils.uuid & {_, #type: "product", #value: "76"}
		name:          "Personal Protective Equipment Kit"
		unitCost:      90
		unitPrice:     135
		costCategory:  "Safety"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product77: {
		id: utils.uuid & {_, #type: "product", #value: "77"}
		name:          "Solar Panel Transport Rack"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product78: {
		id: utils.uuid & {_, #type: "product", #value: "78"}
		name:          "Oversized Load Transport Permit"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product79: {
		id: utils.uuid & {_, #type: "product", #value: "79"}
		name:          "Custom Solar Panel Cover"
		unitCost:      50
		unitPrice:     75
		costCategory:  "Logistics"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product80: {
		id: utils.uuid & {_, #type: "product", #value: "80"}
		name:          "Solar Project Management App"
		unitCost:      150
		unitPrice:     225
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product81: {
		id: utils.uuid & {_, #type: "product", #value: "81"}
		name:          "Solar Energy Simulation Software"
		unitCost:      600
		unitPrice:     900
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product82: {
		id: utils.uuid & {_, #type: "product", #value: "82"}
		name:          "Drone for Solar Site Surveys"
		unitCost:      1000
		unitPrice:     1500
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product83: {
		id: utils.uuid & {_, #type: "product", #value: "83"}
		name:          "Thermal Imaging Camera for Inspections"
		unitCost:      2000
		unitPrice:     3000
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product84: {
		id: utils.uuid & {_, #type: "product", #value: "84"}
		name:          "Solar Panel Efficiency Tester"
		unitCost:      800
		unitPrice:     1200
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product85: {
		id: utils.uuid & {_, #type: "product", #value: "85"}
		name:          "Automatic Solar Panel Washer"
		unitCost:      2500
		unitPrice:     3750
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product86: {
		id: utils.uuid & {_, #type: "product", #value: "86"}
		name:          "Solar Farm Land Assessment Service"
		unitCost:      3500
		unitPrice:     5250
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product87: {
		id: utils.uuid & {_, #type: "product", #value: "87"}
		name:          "Renewable Energy Policy Consultation"
		unitCost:      400
		unitPrice:     600
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product88: {
		id: utils.uuid & {_, #type: "product", #value: "88"}
		name:          "Solar Rebate Processing Service"
		unitCost:      250
		unitPrice:     375
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product89: {
		id: utils.uuid & {_, #type: "product", #value: "89"}
		name:          "Green Building Certification Consultation"
		unitCost:      500
		unitPrice:     750
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product90: {
		id: utils.uuid & {_, #type: "product", #value: "90"}
		name:          "Sustainable Energy Grant Writing Service"
		unitCost:      600
		unitPrice:     900
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product91: {
		id: utils.uuid & {_, #type: "product", #value: "91"}
		name:          "Environmental Impact Assessment"
		unitCost:      700
		unitPrice:     1050
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product92: {
		id: utils.uuid & {_, #type: "product", #value: "92"}
		name:          "Solar Energy Storage Consultation"
		unitCost:      450
		unitPrice:     675
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product93: {
		id: utils.uuid & {_, #type: "product", #value: "93"}
		name:          "Renewable Energy Investment Analysis"
		unitCost:      800
		unitPrice:     1200
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product94: {
		id: utils.uuid & {_, #type: "product", #value: "94"}
		name:          "Solar System Retrofitting Service"
		unitCost:      1000
		unitPrice:     1500
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product95: {
		id: utils.uuid & {_, #type: "product", #value: "95"}
		name:          "Energy Efficiency Audit"
		unitCost:      350
		unitPrice:     525
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product96: {
		id: utils.uuid & {_, #type: "product", #value: "96"}
		name:          "Solar Panel Recycling Service"
		unitCost:      200
		unitPrice:     300
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product97: {
		id: utils.uuid & {_, #type: "product", #value: "97"}
		name:          "Utility-Scale Solar Project Development"
		unitCost:      5000
		unitPrice:     7500
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product98: {
		id: utils.uuid & {_, #type: "product", #value: "98"}
		name:          "Custom Solar System Design"
		unitCost:      750
		unitPrice:     1125
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product99: {
		id: utils.uuid & {_, #type: "product", #value: "99"}
		name:          "Solar Carport Construction"
		unitCost:      2000
		unitPrice:     3000
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product100: {
		id: utils.uuid & {_, #type: "product", #value: "100"}
		name:          "Solar Water Heater Installation"
		unitCost:      1000
		unitPrice:     1500
		costCategory:  "Service"
		inventoryType: "SERVICE"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product101: {
		id: utils.uuid & {_, #type: "product", #value: "101"}
		name:          "Photovoltaic Noise Barrier"
		unitCost:      1200
		unitPrice:     1800
		costCategory:  "Hardware"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product102: {
		id: utils.uuid & {_, #type: "product", #value: "102"}
		name:          "Building-Integrated Photovoltaics (BIPV)"
		unitCost:      2200
		unitPrice:     3300
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product103: {
		id: utils.uuid & {_, #type: "product", #value: "103"}
		name:          "Solar Powered ATM"
		unitCost:      2500
		unitPrice:     3750
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product104: {
		id: utils.uuid & {_, #type: "product", #value: "104"}
		name:          "Solar Energy Kiosk"
		unitCost:      1800
		unitPrice:     2700
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product105: {
		id: utils.uuid & {_, #type: "product", #value: "105"}
		name:          "Portable Solar Cooking Solution"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product106: {
		id: utils.uuid & {_, #type: "product", #value: "106"}
		name:          "Solar Powered Water Desalination System"
		unitCost:      3500
		unitPrice:     5250
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product107: {
		id: utils.uuid & {_, #type: "product", #value: "107"}
		name:          "Solar Refrigeration System"
		unitCost:      1500
		unitPrice:     2250
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product108: {
		id: utils.uuid & {_, #type: "product", #value: "108"}
		name:          "Solar Powered Internet Router"
		unitCost:      400
		unitPrice:     600
		costCategory:  "Equipment"
		inventoryType: "INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product109: {
		id: utils.uuid & {_, #type: "product", #value: "109"}
		name:          "Smart Grid Solar Energy Management System"
		unitCost:      2500
		unitPrice:     3750
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product110: {
		id: utils.uuid & {_, #type: "product", #value: "110"}
		name:          "Solar Power Plant Operation Software"
		unitCost:      1200
		unitPrice:     1800
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product111: {
		id: utils.uuid & {_, #type: "product", #value: "111"}
		name:          "Solar Asset Management Platform"
		unitCost:      950
		unitPrice:     1425
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product112: {
		id: utils.uuid & {_, #type: "product", #value: "112"}
		name:          "PV Module Performance Analyzer"
		unitCost:      700
		unitPrice:     1050
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
	Product113: {
		id: utils.uuid & {_, #type: "product", #value: "113"}
		name:          "Renewable Energy Database Subscription"
		unitCost:      300
		unitPrice:     450
		costCategory:  "Software"
		inventoryType: "NON_INVENTORY"
		taxID: utils.uuid & {_, #type: "tax", #value: "3"}
		uom:                  "Units"
		recalculatedLineItem: false
	}
}

Product: {
	items: [
		for k, v in #Products {
			v
		},
	]
}
