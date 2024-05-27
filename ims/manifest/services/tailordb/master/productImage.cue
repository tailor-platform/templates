package master

import (
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"tailor.build/template/manifest/services/tailordb:permissions"
  "tailor.build/template/manifest/services/tailordb:commonType"
)

ProductImage: commonType.#CommonType & {
  Name: "ProductImage",
  Description: "Product Image",
  Settings: {
    BulkUpsert: true,
  }
  Fields: {
    shopifyID: {
      Type: tailordb.#TypeString,
      Description: "Shopify image ID",
    }
    url: {
      Type: tailordb.#TypeString,
      Description: "Image URL",
    }
    altText: {
      Type: tailordb.#TypeString,
      Description: "Alt text",
    }
  }
  TypePermission: permissions.editorAccess
}