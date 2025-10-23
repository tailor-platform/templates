resource "tailor_pipeline_resolver" "get_project_status" {
  workspace_id = var.workspace_id
  namespace    = tailor_pipeline.pipeline.namespace
  name         = "getProjectStatus"
  description  = "List all the tasks for a project"
  authorization = {
    expr = "true"
  }
  sdl = <<EOF
    type ProjectStatusInput {
      projectId: ID!
    }
    type TaskItemResult {
      id: ID
      name: String
      projectId: ID
      dueDate: DateTime
      status: String
    }
    type TasksResult {
      projectId: ID!
      projectName: String
      status: String
      result: [TaskItemResult]
    }
    extend type Query {
      getProjectStatus(input: ProjectStatusInput!): TasksResult
    }
  EOF
  steps = [
    {
      name = "getProjectInfo"
      operation = {
        tailor_graphql = {
          invoker = {
            machine_user = {
              auth_namespace = tailor_auth.prj_mgmt_auth.namespace
              name           = "admin-machine-user"
            }
          }
          query = <<EOF
            query fetchProjectInfo($projectId: ID!) {
              project(id: $projectId) {
                id
                name
                startDate
                endDate
                status
              }
              tasks(query: {projectId: {eq: $projectId}}) {
                collection {
                  id
                  name
                  projectId
                  dueDate
                  status
                }
              }
            }
          EOF
        }
      }
      pre_hook  = <<EOF
        ({
          "projectId": context.args.input.projectId
        })
      EOF
      post_hook = <<EOF
        ({
          "tasks": args.tasks,
          "projectId": context.args.input.projectId,
          "projectName": args.project.name,
          "result": args.tasks.collection.length === 0 ? [] : args.tasks.collection.map(e => ({
            "id": e.id,
            "name": e.name,
            "projectId": e.projectId,
            "dueDate": e.dueDate,
            "status": e.status
          }))
        })
      EOF
    }
  ]
}