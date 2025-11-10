resource "tailor_executor" "new_task_slack_notification" {
  workspace_id = var.workspace_id
  name         = "new-task-slack-notification"
  description  = "notify slack when a new task is created"

  trigger = {
    event = {
      type      = "tailordb.type_record.created"
      condition = <<EOF
        args.namespaceName == "project-management-db" && args.typeName == "Task"
      EOF
    }
  }

  operation = {
    webhook = {
      url = <<EOF
  	"https://hooks.slack.com/services/<your-service-name>"
  	EOF
      headers = [
        {
          key       = "Content-Type"
          raw_value = "application/json"
        }
      ]
      body = <<EOF
  	  ({
  		  "text": "New Task created :tada: " + args.newRecord.name
  	  })
  	EOF
    }
  }
}