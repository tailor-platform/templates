resource "tailor_tailordb_gql_permission" "product" {
  workspace_id = tailor_workspace.demo.id
  namespace    = tailor_tailordb.demo.namespace
  type         = tailor_tailordb_type.example.name

  policies = [
    {
      conditions = [
        { left = { user = "role" }, operator = "eq", right = { value = { string = "ADMIN" } } }
      ]
      actions     = ["all"]
      permit      = "allow"
      description = "Administrators have full access to all GraphQL operations"
    },
    {
      conditions = [
        { left = { user = "_loggedIn" }, operator = "eq", right = { value = { boolean = true } } }
      ]
      actions     = ["create", "read", "update"]
      permit      = "allow"
      description = "Authenticated users can create, read, and update tasks"
    },
  ]
}