package master

import (
	"tailor.build/template/seed/utils"
)

#Locations: {
    Location1: {
        id: utils.uuid & {_, #type: "location", #value: "1"},
        code: 2001,
        name: "Sunset Fabrics",
        address: "123 Sunset Blvd, Los Angeles, CA 90001",
        type: "storefront",
        contactNumber: "213-456-7890"
    },
    Location2: {
        id: utils.uuid & {_, #type: "location", #value: "2"},
        code: 2002,
        name: "Starlight Textiles Warehouse",
        address: "456 Starlight Drive, San Francisco, CA 94101",
        type: "warehouse",
        contactNumber: "415-789-0123"
    },
    Location3: {
        id: utils.uuid & {_, #type: "location", #value: "3"},
        code: 2003,
        name: "Oceanview Linens",
        address: "789 Oceanview Ave, San Diego, CA 92101",
        type: "storefront",
        contactNumber: "619-012-3456"
    },
    Location4: {
        id: utils.uuid & {_, #type: "location", #value: "4"},
        code: 2004,
        name: "Golden Gate Garments Storage",
        address: "321 Golden Gate Ave, San Francisco, CA 94102",
        type: "warehouse",
        contactNumber: "415-234-5678"
    },
    Location5: {
        id: utils.uuid & {_, #type: "location", #value: "5"},
        code: 2005,
        name: "Hollywood Threads",
        address: "654 Hollywood Blvd, Los Angeles, CA 90028",
        type: "storefront",
        contactNumber: "323-345-6789"
    },
    Location6: {
        id: utils.uuid & {_, #type: "location", #value: "6"},
        code: 2006,
        name: "Pacific Textiles Logistics",
        address: "987 Pacific Highway, San Diego, CA 92102",
        type: "warehouse",
        contactNumber: "619-456-7890"
    }
}

Location: {
   items: [
		for k, v in #Locations {
			v
		},
	],
}
