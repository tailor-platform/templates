resource "tailor_executor" "update_project_status" {
  workspace_id = var.workspace_id
  name         = "update-project-status"
  description  = "Update project status to completed when all tasks are completed"
  trigger = {
    event = {
      type      = "tailordb.type_record.updated"
      condition = <<EOF
        args.namespaceName == "pm" && args.typeName == "Task" && args.newRecord.status == "Completed"
      EOF
    }
  }
  operation = {
    tailor_graphql = {
      app_name = tailor_application.project_management.name
      invoker = {
        machine_user = {
          auth_namespace = tailor_auth.prj_mgmt_auth.namespace
          name           = "admin-machine-user"
        }
      }
      query = <<EOF
        mutation ($input: UpdateProjectStatusInput!) {
          updateProjectStatus(input: $input) {
            status
          }
        }
      EOF
      variables = <<EOF
      ({
        "input": {
          "projectId": args.newRecord.projectId
        }
      })
      EOF
    }
  }
}