terraform {
  required_providers {
    tailor = {
      source = "tailor-platform/tailor"
    }
  }
}
provider "tailor" {}

resource "tailor_workspace" "demo" {
  name   = "demo"
  region = "asia-northeast"
}

resource "tailor_application" "demo" {
  workspace_id = tailor_workspace.demo.id
  name         = "demo"
  auth = {
    namespace = tailor_auth.demo.namespace
  }
  subgraphs = [
    {
      type      = "tailordb"
      namespace = tailor_tailordb.demo.namespace
    }
  ]
  depends_on = [
    tailor_tailordb_type.product,
  ]
}

resource "tailor_auth" "demo" {
  workspace_id = tailor_workspace.demo.id
  namespace    = "demo"
}

resource "tailor_auth_machine_user" "admin" {
  workspace_id = tailor_workspace.demo.id
  namespace    = tailor_auth.demo.namespace

  name = "admin"
}

resource "tailor_tailordb" "demo" {
  workspace_id = tailor_workspace.demo.id
  namespace    = "demo"
}

locals {
  tailordb_permission_everyone = {
    create = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    read = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    update = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    delete = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
    admin = [
      {
        attribute = "everyone"
        permit    = "allow"
      }
    ]
  }
}
