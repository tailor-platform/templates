package resolvers

import (
  "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
  "tailor.build/template/services/pipeline:settings"
)

setBinAsDefault: pipeline.#Resolver & {
  Authorization: pipeline.#AuthInsecure
  Name:          "setBinAsDefault"
  Description: """
    Set a bin as the default bin for a warehouse.
  """
  Response: {
    Type: pipeline.Boolean
  }
  Inputs: [
    {Name: "warehouseID"
      Required: true
      Type:     pipeline.ID
    },
    {Name: "binID"
      Required: true
      Type:     pipeline.ID
    },
  ]
  Pipelines: [
    {
      Name: "fetchBinsMarkedAsDefault"
      Description: "Fetch the bins marked as default for the warehouse"
      PreScript: "context.args"
      Invoker: settings.adminInvoker
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          query bins($warehouseID: ID!){
            bins(query: {warehouseID: {eq: $warehouseID}, isDefault: {eq: true}}){
              edges {
                node {
                  id
                }
              }
            }
          }"""
      }
      PostScript: """
          args.bins.edges
        """
    },
    {
      Name: "removeDefaultBin"
      Description: "Remove the default bin for the warehouse"
      Invoker: settings.adminInvoker
      ForEach: "context.pipeline.fetchBinsMarkedAsDefault"
      PreScript: """
        {
          "id": each.node.id,
          "isDefault": false
        }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation updateBin($id: ID!, $isDefault: Boolean!){
            updateBin(id: $id, input: {isDefault: $isDefault}) {
              id
            }
          }"""
      }
    },
    {
      Name: "setBinAsDefault"
      Description: "Set the bin as the default bin for the warehouse"
      Invoker: settings.adminInvoker
      PreScript: """
        {
          "id": context.args.binID,
          "isDefault": true
        }"""
      Operation: pipeline.#GraphqlOperation & {
        Query: """
          mutation updateBin($id: ID!, $isDefault: Boolean!){
            updateBin(id: $id, input: {isDefault: $isDefault}) {
              id
            }
          }"""
      }
    }
  ]
}
