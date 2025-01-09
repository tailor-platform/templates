@if(local)
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
			Name: "minitailor"
			Config: auth.#IDToken & {
				ClientID:    "minitailor"
				ProviderURL: "http://mini.tailor.tech:18888"
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
	]
}
