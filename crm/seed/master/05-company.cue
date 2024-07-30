package master

import (
	"tailor.build/template/seed/utils"
)

#Company: {
	company0: {
		id: utils.uuid & {_, #type: "company", #value: "1"}
		name:        "Alpha Inc"
		url:         "alpha.com"
		linkedInUrl: "linkedin.com/alpha-inc"
		logoUrl:     "alpha.com/logo"
	}
	company1: {
		id: utils.uuid & {_, #type: "company", #value: "2"}
		name:        "Beta Corp"
		url:         "beta.com"
		linkedInUrl: "linkedin.com/beta-corp"
		logoUrl:     "beta.com/logo"
	}
	company2: {
		id: utils.uuid & {_, #type: "company", #value: "3"}
		name:        "Gamma Ltd"
		url:         "gamma.com"
		linkedInUrl: "linkedin.com/gamma-ltd"
		logoUrl:     "gamma.com/logo"
	}
}

Company: {
	items: [
		for k, v in #Company {
			v
		},
	]
}
