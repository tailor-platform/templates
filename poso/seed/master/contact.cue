package master

import (
	"tailor.build/template/seed/utils"
)

#Contacts: {
    Contact1: {
        id: utils.uuid & {_, #type: "contact", #value: "1"},
        name: "Magnolia Village"
		isCustomer: true
		isVendor: false
		billingEmail: "info@magnoliavillage.com"
		billingAddress: "123 Magnolia St"
    },
    Contact2: {
        id: utils.uuid & {_, #type: "contact", #value: "2"},
        name: "Avion At Spectrum"
		isCustomer: true
		isVendor: false
		billingEmail: "info@avonatspectrum.com"
		billingAddress: "123 Avion St"
    }
}

Contact: {
	items: [
		for k, v in #Contacts {
			v
		},
	]
}