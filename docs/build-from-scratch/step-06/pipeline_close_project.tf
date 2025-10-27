resource "tailor_pipeline_resolver" "close_project" {
  workspace_id = var.workspace_id
  namespace    = tailor_pipeline.pipeline.namespace
  name         = "closeProject"
  description  = "Close a project and mark all incomplete tasks as canceled."
  authorization = {
    expr = "true"
  }
  sdl = file("${path.module}/schema/close_project_function.graphql")

  steps = [
    {
      name = "closeProject"
      invoker = {
        machine_user = {
          auth_namespace = tailor_auth.prj_mgmt_auth.namespace
          name           = "admin-machine-user"
        }
      }
      operation = {
        function = {
          name      = "closeProject"
          script = file("${path.module}/scripts/close_project_function.js")
          variables = "({ projectId: context.args.input.projectId })"
        }
      }
    }
  ]

  post_hook = "args.closeProject"
}
