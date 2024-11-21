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
			Name: "pm-auth"
				Config: auth.#OIDC & {
				ClientID: "ulIr9rgHeytUQYSRl9j2WvrwPJn9XaXx"
				ClientSecret: secretmanager.#SecretValue & {
					VaultName: "auth-vault"
					SecretKey: "client-secret"
				}
				ProviderURL: "https://dev-uriukbxe1n5cqxwz.us.auth0.com/"
			}
		},
	]
	OAuth2Clients: [
	auth.#OAuth2Client & {
		Name: "oauth2-client"
		GrantTypes: [
			"authorization_code",
			"refresh_token",
		]
		RedirectURIs: [
			"https://project-management-kv665xkkfa.erp.dev/oauth2/callback",
		]
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
