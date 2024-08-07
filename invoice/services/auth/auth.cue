package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
	"tailor.build/template/services/tailordb"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/environment"
	role "tailor.build/template/seed/master"
)

auth.#Spec & {
	Namespace: environment.#app.namespace
	IdProviderConfigs: [
		auth.#IDProviderConfig & {
			Name: "sample"
				Config: auth.#IDToken & {
				ClientID:    "exampleco"
				ProviderURL: "https://exampleco-enterprises.auth0.com/"
			}
		},
	]
	UserProfileProvider: auth.#UserProfileProviderType.TailorDB
	UserProfileProviderConfig: auth.#TailorDBProviderConfig & {
		Namespace:     tailordb.Namespace
		Type:          master.User.Name
		UsernameField: "email"
		AttributesFields: ["roles"]
	}
	MachineUsers: [
		auth.#MachineUser & {
			Name: "admin-machine-user"
			Attributes: [
				role.#Roles.Admin.id,
			]
		},
		auth.#MachineUser & {
			Name: "manager-machine-user"
			Attributes: [
				role.#Roles.Manager.id,
			]
		},
		auth.#MachineUser & {
			Name: "customer-machine-user"
			Attributes: [
				role.#Roles.Customer.id,
			]
		},
		auth.#MachineUser & {
			Name: "staff-machine-user"
			Attributes: [
				role.#Roles.Staff.id,
			]
		},
	]
}
