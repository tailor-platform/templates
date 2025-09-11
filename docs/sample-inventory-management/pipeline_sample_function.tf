resource "tailor_pipeline_resolver" "sample_function" {
  workspace_id = local.workspace_id
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
          variables = "({ message: context.args.input.message })"
        }
      }
      post_script = <<EOF
	    args.functionSampleHello
      EOF
    }
  ]
}
