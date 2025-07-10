resource "tailor_workspace" "ims" {
  name   = "ims"
  region = "us-west"
}

output "workspace" {
  value = tailor_workspace.ims.id
}
