resource "tailor_pipeline_resolver" "pipeline_insert_data_function" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_pipeline.ims.namespace
  name         = "insertData"
  description  = "sample mutation resolver"
  authorization = {
    insecure = true
  }

  sdl = file("${path.module}/schema/insert_data_function.graphql")

  steps = [
    {
      name = "insertData"
      operation = {
        function = {
          name      = "insertData"
          script    = file("${path.module}/scripts/insert_data_function.js")
          variables = "({ title: context.args.input.title })"
        }
      }
      post_script = <<EOF
      args.insertData
      EOF
    }
  ]
}
