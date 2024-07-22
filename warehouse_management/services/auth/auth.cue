package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
	"tailor.build/template/services/tailordb"
	"tailor.build/template/services/tailordb/master"
	"tailor.build/template/environment"
	role "tailor.build/template/seed/master"
	"github.com/tailor-platform/tailorctl/schema/v2/secretmanager"
)

auth.#Spec & {
	Namespace: environment.#app.namespace
	IdProviderConfigs: [
		auth.#IDProviderConfig & {
			Name: "sample"
			Config: auth.#OIDC & {
				ClientID: "XXXXXXX"
				ClientSecret: secretmanager.#SecretValue & {
					VaultName: "default"
					SecretKey: "oidc-client-secret"
				}
				ProviderURL: "https://exampleco-enterprises.auth0.com/" // please update Provider URL
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