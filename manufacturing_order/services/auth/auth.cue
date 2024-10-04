@if(dev)
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
			Name: "retool-integration"
			Config: auth.#IDToken & {
				ClientID:    "1qkAt22ShoEvt98xF09dH7NsEmC5qkcU"
				ProviderURL: "https://retool-integration.us.auth0.com/"
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
