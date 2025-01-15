resource "tailor_pipeline" "ims" {
  workspace_id = tailor_workspace.ims.id
  namespace    = "ims"

  common_sdl = <<EOF
# here we define common types used in the pipeline
type Mutation {
  dummy: Boolean
}
EOF
}
