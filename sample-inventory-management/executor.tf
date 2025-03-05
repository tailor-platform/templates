resource "tailor_executor" "slack_notification" {
  workspace_id = tailor_workspace.ims.id
  name         = "slack-notification"
  description  = "notify slack when a new product is created"

  trigger = {
	event = {
      type   = "tailordb.type_record.created"
      condition = "args.typeName == \"Product\""
    }
  }

  operation = {
	webhook = {
	  url = <<EOF
    "https://hooks.slack.com/services/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"
    EOF
      headers = [
        {
          key       = "Content-Type"
          raw_value = "application/json"
        }
      ]
      body = <<EOF
        ({
            "text": "New Product Registration :tada:"
        })
      EOF
	}
  }
}

resource "tailor_executor" "event_based_executor" {
  workspace_id = tailor_workspace.ims.id
  name         = "event-based-executor"
  description  = "Execute query based on an event"

  trigger = {
    event = {
      type   = "tailordb.type_record.deleted"
      condition = <<EOF
        args.namespaceName == "ims" && args.typeName == "Order"
      EOF
    }
  }

  operation = {
    tailor_graphql = {
      app_name = tailor_application.ims.name
      invoker = {
        event_user = true
      }
      query     = <<EOF
        mutation createOrderItem($quantity: integer!) {
          createOrderItem( quantity: $quantity)
        }
      EOF
      variables = <<EOF
        ({
            input: {
  			"quantity": args.newRecord.quantity
  		  }
        })
      EOF
    }
  }
}

resource "tailor_executor" "eventbased_executor_2" {
  workspace_id = tailor_workspace.ims.id
  name         = "eventbased-executor-2"
  description  = "Create new product based on the event"

  trigger = {
    event = {
      type   = "pipeline.resolver.executed"
      condition = <<EOF
        args.namespaceName == "ims" && args.resolverName == "createShipmentFromSalesOrder" && args.succeeded != null
      EOF
    }
  }

  operation = {
    tailor_graphql = {
      app_name = tailor_application.ims.name
      invoker = {
        event_user = true
      }
    query     = <<EOF
      mutation createProduct($title: String!, $description: String!) {
		createProduct(input: {title: $title, description: $description}) {
		  id
		}
	  }
    EOF
    variables = <<EOF
      ({
		  "title": args.succeeded.result.pipelines.createShipment.id,
		  "description": "Created with a trigger"
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

resource "tailor_executor" "scheduled_event_executor" {
  workspace_id = tailor_workspace.ims.id
  name         = "scheduled-event-executor"
  description  = "execute query after an event"

  trigger = {
    schedule = {
	  frequency = "* * * * *"
	  timezone = "UTC"
	}
  }

  operation = {
    webhook = {
      url = "http://localhost"
	  secret = {
		secret_name = "key"
		vault_name = "vault"
	  } 
    }
  }
}
