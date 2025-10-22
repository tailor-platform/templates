resource "tailor_pipeline" "pipeline" {
  workspace_id = var.workspace_id
  namespace    = "project-management"

  common_sdl = <<EOF
    type Query {
      dummy: String
    }
    type Mutation {
      dummy: String
    }
  EOF
}