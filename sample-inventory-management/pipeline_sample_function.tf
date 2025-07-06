resource "tailor_pipeline_resolver" "sample_function" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_pipeline.ims.namespace

  name        = "functionSampleHello"
  description = "sample query resolver"
  authorization = {
    insecure = true
  }

  sdl = file("${path.module}/schema/sample_function.graphql")

  steps = [
    {
      name = "functionSampleHello"
      operation = {
        function = {
          name      = "functionSampleHello"
          script = file("${path.module}/scripts/sample_function.js")
          variables = "({ message: user.id })"
        }
      }
      post_script = <<EOF
	    args.functionSampleHello
      EOF
    }
  ]
}
