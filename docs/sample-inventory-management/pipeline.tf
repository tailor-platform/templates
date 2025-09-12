resource "tailor_pipeline" "ims" {
  workspace_id = var.workspace_id
  namespace    = "ims"

  common_sdl = <<EOF
# here we define common types used in the pipeline
type Query {
  dummy: Boolean
}

type Mutation {
  dummy: Boolean
}
EOF
}
