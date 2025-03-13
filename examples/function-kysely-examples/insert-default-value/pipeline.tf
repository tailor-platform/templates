resource "tailor_pipeline_resolver" "register_user" {
  workspace_id = tailor_workspace.demo.id
  namespace    = tailor_pipeline.demo.namespace
  name         = "registerUser"

  authorization = {
    insecure = true
  }

  sdl = <<EOF
    input registerUserInput {
      name: String
    }
    type registerUserOutput {
      success: Boolean!
    }
    extend type Mutation {
      registerUser(input: registerUserInput!): registerUserOutput!
    }
  EOF

  steps = [{
    name = "exec"
    operation = {
      function = {
        name      = "exec"
        script    = file("${path.module}/function/dist/register-user.js")
        variables = "args.input"
      }
    }
  }]

  post_hook = "({ success: true })"
}
