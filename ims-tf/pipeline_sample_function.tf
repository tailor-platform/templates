# resource "tailor_pipeline_resolver" "sample_function" {
#   workspace_id = tailor_workspace.ims.id
#   namespace    = tailor_pipeline.ims.namespace
#   name        = "functionSampleHello"
#   description = "query resolver for getting heroes"
#   authorization = {
#     insecure = true
#   }

#   sdl = file("${path.module}/schema/sample_function.graphql")

#   steps = [
#     {
#       name = "functionSampleOperationHello"
#       operation = {
#         function = {
#           name      = "helloFunction"
#           script = file("${path.module}/scripts/sample_function.js")
#           variables = "({ message: context.args.input.message })"
#         }
#       }
#       post_script = <<EOF
#       {
#       "message" : args.helloFunction.message
#       }
#       EOF
#     }
#   ]
# }

