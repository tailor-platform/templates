resource "tailor_workspace" "ims" {
  name   = var.workspace_id
  region = "us-west"
}

output "workspace" {
  value = tailor_workspace.ims.id
}
