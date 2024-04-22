package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
	"tailor.build/template/manifest/services/tailordb"
	"tailor.build/template/manifest/services/tailordb/master"
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
				ProviderURL: "https://XXXXXXX.auth0.com/"
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
