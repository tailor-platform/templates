package master

import (
	"tailor.build/template/seed/utils"
)

#Taxes: {
    Tax1: {
        id: utils.uuid & {_, #type: "tax", #value: "1"},
        name: "TVA 0%",
        taxRate: 0
    },
    Tax2: {
        id: utils.uuid & {_, #type: "tax", #value: "2"},
        name: "TVA 15%",
        taxRate: 0.15
    },
    Tax3: {
        id: utils.uuid & {_, #type: "tax", #value: "3"},
        name: "TVA 10%",
        taxRate: 0.1
    }
}

Tax: {
	items: [
		for k, v in #Taxes {
			v
		},
	]
}


