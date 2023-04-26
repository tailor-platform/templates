package graphqlseed

import (
  "uuid"
  "crypto/hmac"
  "github.com/tailor-inc/platform-core-services/tailorctl/schema/v1:manifest"
)

#seed: uuid.FromInt(3)

manifest.#TailorManifest & {
  version: "v1"
  kind:    manifest.#KindGraphqlSeed
  spec:    manifest.#SpecGraphqlSeed & {
    mutations: [
      {
        query: """
          mutation ($pid1: ID, $pid2: ID, $pid3: ID, $pid4: ID, $pid5: ID) {
            product1: createProduct(
              input: {
                id: $pid1
                pricePerUnit: 10
                eanCode: "0123456789101"
                uom: "kg"
                productCategory: "Material"
                productName: "TEST1"
                productCode: 1
              }
            ) {
              id
            }
            product2: createProduct(
              input: {
                id: $pid2
                pricePerUnit: 20
                eanCode: "0123456789101"
                uom: "kg"
                productCategory: "Material"
                productName: "TEST2"
                productCode: 2
              }
            ) {
              id
            }
            product3: createProduct(
              input: {
                id: $pid3
                pricePerUnit: 30
                eanCode: "0123456789101"
                uom: "yd"
                productCategory: "Material"
                productName: "TEST3"
                productCode: 3
              }
            ) {
              id
            }
            product4: createProduct(
              input: {
                id: $pid4
                pricePerUnit: 40
                eanCode: "0123456789101"
                uom: "yd"
                productCategory: "Material"
                productName: "TEST4"
                productCode: 4
              }
            ) {
              id
            }
            product5: createProduct(
              input: {
                id: $pid5
                pricePerUnit: 50
                eanCode: "0123456789101"
                uom: "yd"
                productCategory: "Material"
                productName: "TEST5"
                productCode: 5
              }
            ) {
              id
            }
          } """
        variables: {
          pid1: uuid.SHA1(#seed, hmac.Sign("SHA1", "Product", "1"))
          pid2: uuid.SHA1(#seed, hmac.Sign("SHA1", "Product", "2"))
          pid3: uuid.SHA1(#seed, hmac.Sign("SHA1", "Product", "3"))
          pid4: uuid.SHA1(#seed, hmac.Sign("SHA1", "Product", "4"))
          pid5: uuid.SHA1(#seed, hmac.Sign("SHA1", "Product", "5"))
        }
      },
      {
        query: """
          mutation ($plid1: ID, $plid2: ID) {
            location1: createLocation(
              input: {
                id: $plid1
                locationCode: 1
                locationName: "test01"
                country: "USA"
                city: "CA"
                address1: "address1"
                address2: "address2"
                zipcode: "12345"
              }
            ) {
              id
            }
            location2: createLocation(
              input: {
                id: $plid2
                locationCode: 2
                locationName: "test02"
                country: "USA"
                city: "CA"
                address1: "address1"
                address2: "address2"
                zipcode: "12345"
              }
            ) {
              id
            }
          } """
        variables: {
          plid1: uuid.SHA1(#seed, hmac.Sign("SHA1", "Location", "1"))
          plid2: uuid.SHA1(#seed, hmac.Sign("SHA1", "Location", "2"))
        }
      },
    ]
  }
}
