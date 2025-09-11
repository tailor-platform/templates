locals {
  workspace_id = var.workspace_id != "" ? var.workspace_id : tailor_workspace.ims.id
}
