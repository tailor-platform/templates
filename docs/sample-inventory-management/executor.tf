resource "tailor_executor" "slack_notification" {
  workspace_id = var.workspace_id
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
    "https://hooks.slack.com/services/yourServiceName"
    EOF
      headers = [
        {
          key       = "Content-Type"
          raw_value = "application/json"
        }
      ]
      body = <<EOF
        ({
            "text": "New Product Registration :tada: " + args.newRecord.title
        })
      EOF
	}
  }
}

resource "tailor_executor" "event_based_executor" {
  workspace_id = var.workspace_id
  name         = "event-based-executor"
  description  = "Execute query based on an event"

  trigger = {
    event = {
      type      = "tailordb.type_record.created"
      condition = <<EOF
        args.namespaceName == "ims" && args.typeName == "Category"
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
        mutation createProduct($categoryID: ID!, $title: String!) {
        createProduct(input: {
            categoryID: $categoryID
            title: $title
        }) {
            id
        }
        }
        EOF
      variables = <<EOF
        ({
        "categoryID": args.newRecord.id,
        "title": args.newRecord.name + "Product"
        })
        EOF
    }
  }
}

resource "tailor_executor" "eventbased_executor_pipeline_1" {
  workspace_id = var.workspace_id
  name         = "eventbased-executor-pipeline-1"
  description  = "Create new product based on a successful event"

  trigger = {
    event = {
      type   = "pipeline.resolver.executed"
      condition = <<EOF
        args.namespaceName == "ims" && args.resolverName == "createCategoryForProduct" && args.succeeded != null
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
		  "title": args.succeeded.result.pipelines.createProduct.id,
		  "description": "Created with a trigger"
	  })
    EOF
    }
  }
}

resource "tailor_executor" "eventbased_executor_pipeline_2" {
  workspace_id = var.workspace_id
  name         = "eventbased-executor-pipeline-2"
  description  = "Create new product based on a failed pipeline"

  trigger = {
    event = {
      type   = "pipeline.resolver.executed"
      condition = <<EOF
        args.namespaceName == "ims" && args.resolverName == "createCategoryForProduct" && args.failed != null
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
      mutation createProduct($title: String!) {
		createProduct(input: {title: $title}) {
		  id
		}
	  }
    EOF
    variables = <<EOF
      ({
		  "title": args.failed.error
	  })
    EOF
    }
  }
}

resource "tailor_executor" "incoming_webhook_based_executor" {
  workspace_id = var.workspace_id
  name         = "incoming-webhook-based-executor"
  description  = "exposes an endpoint"

  trigger = {
    webhook = {}
  }

  operation = {
	tailor_graphql = {
      app_name = tailor_application.ims.name
      invoker = {
        event_user = true
      }
    query     = <<EOF
      mutation createProduct($title: String!) {
		createProduct(input: {title: $title}) {
		  id
		}
	  }
    EOF
    variables = <<EOF
      ({
		  "title": args.title
	  })
    EOF
    }
  }
}
