resource "tailor_pipeline_resolver" "add_user" {
  workspace_id = tailor_workspace.ims.id
  namespace    = tailor_pipeline.ims.namespace

  name        = "addUser"
  description = "Add a new user"
  authorization = {
    insecure = true
  }

  sdl = file("${path.module}/schema/add_user.graphql")

  steps = [
  {
    name     = "addUserStep"
    pre_hook = <<EOF
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
    post_hook = <<EOF
    ({
      "id": args.addUser.id,
      "name": args.addUser.name,
    })
    EOF
  }]
}