resource "tailor_auth" "prj_mgmt_auth" {
  workspace_id = var.workspace_id
  namespace    = "prj-mgmt-auth"
}

resource "tailor_auth_user_profile_config" "user" {
  workspace_id = var.workspace_id
  namespace    = tailor_auth.prj_mgmt_auth.namespace

  tailordb_config = {
    namespace      = tailor_tailordb.prj_mgmt.namespace
    type           = tailor_tailordb_type.user.name
    username_field = "email"
    attribute_fields = [
      "roles"
    ]
  }
}

resource "tailor_auth_machine_user" "admin_machine_user" {
  workspace_id = var.workspace_id
  namespace    = tailor_auth.prj_mgmt_auth.namespace

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
