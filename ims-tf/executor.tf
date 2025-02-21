resource "tailor_executor" "slack_notification" {
  workspace_id = tailor_workspace.ims.id
  name         = "slack-notification"
  description  = "notify slack when new product is created"

  trigger = {
	event = {
      type   = "tailordb.type_record.created"
      condition = <<EOF
        args.namespaceName == "ims" && args.typeName == "Product"
      EOF
    }
  }

  operation = {
	webhook = {
	  url = "https://hooks.slack.com/services/servicename/"
      headers = [
        {
          key       = "Content-Type"
          raw_value = "application/json"
        }
      ]
	  body = <<EOF
		({
		  "text": "New Product Registration :tada:",
		  "blocks": [
			{
			  "type": "section",
			  "text": {
				"type": "mrkdwn",
				"text": "*New Product Registration* :tada: " + args.newRecord.name
			  }
		    }
		  ]
		})
	  EOF
	}
  }
}

resource "tailor_executor" "incoming_webhook_based_executor" {
  workspace_id = tailor_workspace.ims.id
  name         = "incoming-webhook-based-executor"
  description  = "exposes an endpoint"

  trigger = {
    webhook = {}
  }

  operation = {
	webhook = {
	  url = "http://localhost"
	}
  }
}