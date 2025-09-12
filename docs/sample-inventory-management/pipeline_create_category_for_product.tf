resource "tailor_pipeline_resolver" "pipeline_create_category_for_product" {
  workspace_id = var.workspace_id
  namespace = tailor_pipeline.ims.namespace
  name = "createCategoryForProduct"
  description = "This API is an alternative to createCategory. It creates a Category record and then creates Product record. Use this API if you want to create a Category record and Product record in one API call."
  authorization = {
    insecure = true
  }
  publish_execution_events = "true"

  sdl = <<EOF
    input addCategoryAndProductInput {
      name: String!
      productTitle: String!
      productDescription: String!
    }
    type addCategoryAndProductResponse {
      id: ID!
    }

    extend type Mutation {
      createCategoryForProduct(input: addCategoryAndProductInput!): addCategoryAndProductResponse!
    }
  EOF

  steps = [
    {
      name = "createCategory"
      pre_script = <<EOF
        ({
            "categoryName": context.args.input.name,
            "productTitle": context.args.input.productTitle,
            "productDescription": context.args.input.productDescription
        })
      EOF
      operation = {
        tailor_graphql = {
          invoker = {
            event_user = true
          }
          query = <<EOF
            mutation createCategory ($categoryName: String!) {
              createCategory (input: { name: $categoryName }) {
                id
              }
		    }
          EOF
        }
      }
      post_script = <<EOF
        args.createCategory
      EOF
    },
    {
      name:        "createProduct"
      description: "Create a new Product record with the Category id created in the previous step."
      pre_script = <<EOF
        ({
          "categoryID": context.pipeline.createCategory.id,
          "title":  context.args.input.productTitle,
          "description":  context.args.input.productDescription,  
        })
      EOF
      operation = {
        tailor_graphql = {
          invoker = {
            event_user = true
          }
          query = <<EOF
            mutation createProduct ($categoryID: ID!, $title: String!, $description: String!) {
              createProduct (input: {categoryID: $categoryID, title: $title, description: $description}) {
                id
              } 
            }
          EOF
        }
      }
      post_script: "args.createProduct"
    },
  ]
}
