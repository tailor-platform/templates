package graphqlseed

import (
  "github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
  "{{ .Values.cue.package }}/charts/common:constant"
)

users: {
  jdoe: constant.uuid & {_, #type: "User", #value: "1"}
  mdavis: constant.uuid & {_, #type: "User", #value: "2"}
}

clients: {
  jdoe: constant.uuid & {_, #type: "Client", #value: "1"}
  mdavis: constant.uuid & {_, #type: "Client", #value: "2"}
}

manifest.#TailorManifest & {
  version: "v1"
  kind:    manifest.#KindGraphqlSeed
  spec:    manifest.#SpecGraphqlSeed & {
    mutations: [
      {
        query: """
          mutation ($jDoeUserId: ID, $mDavisUserId: ID) {
            jDoe: createUser(
              input: {
                id: $jDoeUserId,
                username: "jdoe",
                displayName: "John Doe",
                secret: "passw0rd"
              }
            ) {
              id
            }

            mDavis: createUser(
              input: {
                id: $mDavisUserId,
                username: "mdavis",
                displayName: "Michael Davis",
                secret: "passw0rd"
              }
            ) {
              id
            }
          }
        """
        variables: {
          jDoeUserId: users.jdoe,
          mDavisUserId: users.mdavis
        }
      },
      {
        query: """
          mutation ($jDoeId: ID, $mDavisId: ID, $jDoeUserId: ID, $mDavisUserId: ID) {
            JDoe: createClient(
              input: {
                id: $jDoeId,
                email: "jdoe@gmail.com",
                userId: $jDoeUserId,
                billingAddress: "456 Park Ave, Springfield, USA 67890"
              }
            ) {
              id
            }

            MDavis: createClient(
              input: {
                id: $mDavisId,
                email: "mdavis@gmail.com",
                userId: $mDavisUserId,
                billingAddress: "1313 Pine St, Greendale, USA 78901"
              }
            ) {
              id
            }
          }
        """
        variables: {
          jDoeId: clients.jdoe,
          mDavisId: clients.mdavis,
          jDoeUserId: users.jdoe,
          mDavisUserId: users.mdavis
        }
      },
      {
        query: """
          mutation ($jDoeId: ID!, $mDavisId: ID!, $completedServiceRequestId: ID!) {
            sr1: createRequest(
              input: {
                clientId: $jDoeId,
                description: "Office license expired",
                system: PC,
                kind: SOFTWARE_INSTALLATION
              }
            ) {
              id
            }

            sr2: createRequest(
              input: {
                id: $completedServiceRequestId,
                clientId: $jDoeId,
                description: "I need a new laptop",
                system: PC,
                kind: HARDWARE_SETUP,
                status: "COMPLETED"
              }
            ) {
              id
            }

            sr3: createRequest(
              input: {
                clientId: $mDavisId,
                description: "WiFi network is slow",
                system: MAC,
                kind: NETWORKING
              }
            ) {
              id
            }
          }
        """
        variables: {
          jDoeId: clients.jdoe,
          mDavisId: clients.mdavis,
          completedServiceRequestId: constant.uuid & {_, #type: "ServiceRequest", #value: "2"}
        }
      },
      {
        query: """
          mutation ($jDoeId: ID!, $completedServiceRequestId: ID!) {
            createInvoice(
              input: {
                requestId: $completedServiceRequestId,
                clientId: $jDoeId,
                amount: 2000,
              }
            ) {
              id
            }
          }
        """
        variables: {
          jDoeId: clients.jdoe,
          completedServiceRequestId: constant.uuid & {_, #type: "ServiceRequest", #value: "2"}
        }
      }
    ]
  }
}
