package seed

import (
	"github.com/tailor-inc/platform-core-services/e2e/manifest/seed/constant"
)

Affiliations: {
	RebelAlliance: {
		id: constant.Uuid & {_, #type: "roles", #value: "Rebel Alliance"}
		name: "Rebel Alliance"
	}
	GalacticEmpire: {
		id: constant.Uuid & {_, #type: "roles", #value: "Galactic Empire"}
		name: "Galactic Empire"
	}
	FirstOrder: {
		id: constant.Uuid & {_, #type: "roles", #value: "First Order"}
		name: "First Order"
	}
	Resistance: {
		id: constant.Uuid & {_, #type: "roles", #value: "Resistance"}
		name: "Resistance"
	}
	TradeFederation: {
		id: constant.Uuid & {_, #type: "roles", #value: "Trade Federation"}
		name: "Trade Federation"
	}
	GunganGrandArmy: {
		id: constant.Uuid & {_, #type: "roles", #value: "Gungan Grand Army"}
		name: "Gungan Grand Army"
	}
	RoyalNaboo: {
		id: constant.Uuid & {_, #type: "roles", #value: "Royal Naboo"}
		name: "Royal Naboo"
	}
}

AffiliationsArray: [for k, v in Affiliations {id: v.id, name: v.name}]
