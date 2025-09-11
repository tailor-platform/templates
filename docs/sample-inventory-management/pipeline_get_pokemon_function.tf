resource "tailor_pipeline_resolver" "pipeline_get_pokemon_function" {
  workspace_id = local.workspace_id
  namespace = tailor_pipeline.ims.namespace
  name = "getPokemon"
  description = "sample query resolver"
  authorization = {
    insecure = true
  }

  sdl = file("${path.module}/schema/get_pokemon_function.graphql")

  steps = [
    {
      name = "getPokemon"
      operation = {
        function = {
          name = "getPokemon"
          script = file("${path.module}/scripts/dist/get_pokemon_function.js")
          variables = "({ pokemon: context.args.input.pokemon })"
        }
      }
      post_script = <<EOF
      args.getPokemon
      EOF
    }
  ]
}
