resource "tailor_application" "ims" {
  workspace_id = var.workspace_id

  name = "ims"
  cors = [
    "http://localhost:8080",
    "http://localhost:8081",
  ]
  allowed_ip_addresses = [
    "0.0.0.0/0",
  ]
  auth = {
    namespace       = tailor_auth.ims_auth.namespace
    idp_config_name = tailor_auth_idp_config.idp_config.name
  }
  subgraphs = [
    {
      type      = "tailordb"
      namespace = tailor_tailordb.ims.namespace
    },
    {
      type      = "pipeline"
      namespace = tailor_pipeline.ims.namespace
    },
    {
      type      = "auth"
      namespace = tailor_auth.ims_auth.namespace
    }
  ]
}

