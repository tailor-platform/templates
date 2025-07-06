resource "tailor_auth" "ims_auth" {
  workspace_id = tailor_workspace.ims.id
  namespace    = "ims-auth"
}

resource "tailor_auth_idp_config" "saml" {
  workspace_id = tailor_workspace.ims.id
  namespace = tailor_auth.ims_auth.namespace
  name = "saml"
  
  saml_config = {
    metadata_url = "https://dev-uriukbxe1n5cqxwz.us.auth0.com/samlp/metadata/ulIr9rgHeytUQYSRl9j2WvrwPJn9XaXx"
    sp_cert_base64 = {
      vault_name = tailor_secretmanager_vault.default.name
      secret_name = tailor_secretmanager_secret.saml-cert.name
    }
    sp_key_base64 = {
      vault_name = tailor_secretmanager_vault.default.name
      secret_name = tailor_secretmanager_secret.saml-key.name
    }
  }
}

resource "tailor_auth_oauth2_client" "oauth2-client" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_auth.ims_auth.namespace

  name        = "oauth2-client"
  description = "Oauth2 client"
  redirect_uris = [
    "http://localhost:3000/__oauth/callback",
    "http://tailorctl.tailor.tech:8086/callback"
  ]
  grant_types = [
    "authorization_code",
    "refresh_token",
  ]
}

resource "tailor_auth_user_profile_config" "character" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_auth.ims_auth.namespace

  tailordb_config = {
    namespace      = tailor_tailordb.ims.namespace
    type           = tailor_tailordb_type.character.name
    username_field = "email"
    attribute_fields = [
      "roles"
    ]
  }
}

resource "tailor_auth_machine_user" "r2d2" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_auth.ims_auth.namespace

  name = "r2d2"
  attributes = [
    uuid(),
  ]

  lifecycle {
    ignore_changes = [
      attributes,
    ]
  }
}
