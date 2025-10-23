resource "tailor_pipeline_resolver" "update_project_status" {
  workspace_id = var.workspace_id
  namespace    = tailor_pipeline.pipeline.namespace
  name         = "updateProjectStatus"
  description  = "Update the project status to completed when all tasks are completed"
  authorization = {
    expr = "true"
  }
  sdl = <<EOF
    type UpdateProjectStatusInput {
      projectId: ID!
    }
    type ProjectResult {
      projectId: ID!
      status: String
    }
    extend type Mutation {
      updateProjectStatus(input: UpdateProjectStatusInput!): ProjectResult
    }
  EOF
  steps = [
    {
      name = "getTaskInfo"
      operation = {
        tailor_graphql = {
          invoker = {
            machine_user = {
              auth_namespace = tailor_auth.prj_mgmt_auth.namespace
              name           = "admin-machine-user"
            }
          }
          query = <<EOF
            query fetchAllTasksForProject($projectId: ID!) {
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
          "projectId": context.args.input.projectId,
          "tasks": args.tasks.collection
        })
      EOF
    },
    {
      name = "checkTaskStatusAndUpdateProject"
      operation = {
        tailor_graphql = {
          invoker = {
            machine_user = {
              auth_namespace = tailor_auth.prj_mgmt_auth.namespace
              name           = "admin-machine-user"
            }
          }
          query = <<EOF
            mutation updateProject($projectId: ID!, $status: String!) {
              updateProject(id: $projectId, input: {status: $status}) {
                status
              }
            }
          EOF
        }
      }
      pre_hook  = <<EOF
        (() => {
        // Check if all tasks are completed
        const allTasksCompleted = context.pipeline.getTaskInfo.tasks.every(task => 
          task.status === 'Completed'
        );
      
        // Return task status information
        return {
          'projectId': context.args.input.projectId,
          'status': allTasksCompleted ? 'Completed' : 'In Progress'
        };
        })()
      EOF
      post_hook = <<EOF
        ({
            "projectId": context.args.input.projectId,
            "status": args.updateProject.status
        })
      EOF
    }
  ]
}