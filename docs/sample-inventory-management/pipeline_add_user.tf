resource "tailor_pipeline_resolver" "add_user" {
  workspace_id = var.workspace_id
  namespace    = tailor_pipeline.ims.namespace

  name        = "addUser"
  description = "Add a new user"
  authorization = {
    insecure = true
  }

  sdl = file("${path.module}/schema/add_user.graphql")

  steps = [
  {
    name     = "createUserInfo"
    pre_script = <<EOF
    ({
      "name": context.args.input.name,
      "email": context.args.input.email
    })
    EOF
    operation = {
      tailor_graphql = {
        invoker = {
          event_user = true
        }
        query = <<EOF
          mutation($name: String!, $email: String!) {
          createUser(input: {
            name: $name,
            email: $email
          }) {
               id
               name
            }
          }
        EOF
      }
    }
    post_script = <<EOF
      args.createUser
    EOF
  }]
}
