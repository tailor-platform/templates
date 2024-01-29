package auth

import (
	"github.com/tailor-platform/tailorctl/schema/v2/auth"
	"github.com/tailor-platform/tailorctl/schema/v2/secretmanager"
	"github.com/tailor-inc/platform-core-services/e2e/manifest/services/tailordb"
	ttype "github.com/tailor-inc/platform-core-services/e2e/manifest/services/tailordb/type"
)

auth.#Spec & {
	namespace: "starwars-auth"
	idProviderConfigs: [
		auth.#IDProviderConfig & {
			name: "starwars-oidc-app1"
			config: auth.#OIDC & {
				clientID: "tLnCzd7fiIggmeXpFopfnH02j7ibe1ah"
				clientSecret: secretmanager.#SecretValue & {
					vaultName: "default"
					secretKey: "oidc-client-secret"
				}
				providerURL: "https://star-wars.jp.auth0.com/"
			}
		},
		auth.#IDProviderConfig & {
			name: "starwars-saml-app2"
			config: auth.#SAML & {
				metadataURL: "https://tailor.okta.com/app/exk9rts5knoCIpsKc697/sso/saml/metadata"
				spCertBase64: secretmanager.#SecretValue & {
					vaultName: "default"
					secretKey: "saml-cert"
				}
				spKeyBase64: secretmanager.#SecretValue & {
					vaultName: "default"
					secretKey: "saml-key"
				}
			}
		},
	]
	userProfileProvider: auth.#UserProfileProviderType.TailorDB
	userProfileProviderConfig: auth.#TailorDBProviderConfig & {
		namespace:     tailordb.namespace
		type:          ttype.Character.name
		usernameField: "email"
		attributesFields: ["roles"]
	}
}
