package seed

import (
	"github.com/tailor-inc/platform-core-services/e2e/manifest/seed/constant"
)

Roles: {
	BountyHunter: {
		id: constant.Uuid & {_, #type: "roles", #value: "BountyHunter"}
		name: "Bounty Hunter"
	}
	Smuggler: {
		id: constant.Uuid & {_, #type: "roles", #value: "Smuggler"}
		name: "Smuggler"
	}
	ImperialAgent: {
		id: constant.Uuid & {_, #type: "roles", #value: "ImperialAgent"}
		name: "Imperial Agent"
	}
	Trooper: {
		id: constant.Uuid & {_, #type: "roles", #value: "Trooper"}
		name: "Trooper"
	}
	SithLoad: {
		id: constant.Uuid & {_, #type: "roles", #value: "SithLoad"}
		name: "Sith Load"
	}
	SithApprentice: {
		id: constant.Uuid & {_, #type: "roles", #value: "SithApprentice"}
		name: "Sith Apprentice"
	}
	SithInquisitor: {
		id: constant.Uuid & {_, #type: "roles", #value: "SithInquisitor"}
		name: "Sith Inquisitor"
	}
	JediPadawan: {
		id: constant.Uuid & {_, #type: "roles", #value: "JediPadawan"}
		name: "Jedi Padawan"
	}
	JediKnight: {
		id: constant.Uuid & {_, #type: "roles", #value: "JediKnight"}
		name: "Jedi Knight"
	}
	JediMaster: {
		id: constant.Uuid & {_, #type: "roles", #value: "JediMaster"}
		name: "Jedi Master"
	}
}

RolesArray: [for k, v in Roles {id: v.id, name: v.name}]
