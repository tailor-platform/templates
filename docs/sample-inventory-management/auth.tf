resource "tailor_auth" "ims_auth" {
  workspace_id = var.workspace_id
  namespace    = "ims-auth"
}

resource "tailor_auth_idp_config" "idp_config" {
  workspace_id = var.workspace_id
  namespace    = tailor_auth.ims_auth.namespace
  name         = "idp"
  id_token_config = {
    client_id    = var.client_id
    provider_url = var.provider_url
  }
}

resource "tailor_auth_user_profile_config" "character" {
  workspace_id = var.workspace_id
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

resource "tailor_auth_machine_user" "admin_machine_user" {
  workspace_id = var.workspace_id
  namespace    = tailor_auth.ims_auth.namespace

  name = "admin-machine-user"
  attributes = [
    uuid(),
  ]

  lifecycle {
    ignore_changes = [
      attributes,
    ]
  }
}
