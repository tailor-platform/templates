package seed

import (
	"github.com/tailor-inc/platform-core-services/e2e/manifest/seed/constant"
)

Species: {
	Human: {
		id: constant.Uuid & {_, #type: "roles", #value: "Human"}
		name: "Human"
	}
	Droids: {
		id: constant.Uuid & {_, #type: "roles", #value: "Droids"}
		name: "Droids"
	}
	Wookiees: {
		id: constant.Uuid & {_, #type: "roles", #value: "Wookiees"}
		name: "Wookiees"
	}
	Ewoks: {
		id: constant.Uuid & {_, #type: "roles", #value: "Ewoks"}
		name: "Ewoks"
	}
	Gungans: {
		id: constant.Uuid & {_, #type: "roles", #value: "Gungans"}
		name: "Gungans"
	}
	MonCalamari: {
		id: constant.Uuid & {_, #type: "roles", #value: "Mon Calamari"}
		name: "Mon Calamari"
	}
	Toydarians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Toydarians"}
		name: "Toydarians"
	}
	YodaSpecies: {
		id: constant.Uuid & {_, #type: "roles", #value: "Yoda's species"}
		name: "Yoda's species"
	}
	Trandoshans: {
		id: constant.Uuid & {_, #type: "roles", #value: "Trandoshans"}
		name: "Trandoshans"
	}
	Rodians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Rodians"}
		name: "Rodians"
	}
	Hutt: {
		id: constant.Uuid & {_, #type: "roles", #value: "Hutt"}
		name: "Hutt"
	}
	Tholothians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Tholothians"}
		name: "Tholothians"
	}
	Iktotchi: {
		id: constant.Uuid & {_, #type: "roles", #value: "Iktotchi"}
		name: "Iktotchi"
	}
	Quermians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Quermians"}
		name: "Quermians"
	}
	KelDor: {
		id: constant.Uuid & {_, #type: "roles", #value: "Kel Dor"}
		name: "Kel Dor"
	}
	Chagrians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Chagrians"}
		name: "Chagrians"
	}
	Geonosians: {
		id: constant.Uuid & {_, #type: "roles", #value: "Geonosians"}
		name: "Geonosians"
	}
	Mirialans: {
		id: constant.Uuid & {_, #type: "roles", #value: "Mirialans"}
		name: "Mirialans"
	}
	Clawdites: {
		id: constant.Uuid & {_, #type: "roles", #value: "Clawdites"}
		name: "Clawdites"
	}
	Besalisk: {
		id: constant.Uuid & {_, #type: "roles", #value: "Besalisk"}
		name: "Besalisk"
	}
	Kaminoans: {
		id: constant.Uuid & {_, #type: "roles", #value: "Kaminoans"}
		name: "Kaminoans"
	}
	Skakoans: {
		id: constant.Uuid & {_, #type: "roles", #value: "Skakoans"}
		name: "Skakoans"
	}
	Muuns: {
		id: constant.Uuid & {_, #type: "roles", #value: "Muuns"}
		name: "Muuns"
	}
}

SpeciesArray: [for k, v in Species {id: v.id, name: v.name}]
