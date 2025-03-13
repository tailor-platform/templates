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
  region = "local"
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
    },
    {
      type      = "pipeline"
      namespace = tailor_pipeline.demo.namespace
    }
  ]
  depends_on = [
    tailor_tailordb_type.user,
    tailor_pipeline_resolver.register_user
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
resource "tailor_pipeline" "demo" {
  workspace_id = tailor_workspace.demo.id
  namespace    = "demo"
  common_sdl   = <<EOF
    type Query {
      dummy: String
    }
    type Mutation {
      dummy: String
    }
  EOF
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
