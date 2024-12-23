// Corrected pipeline code:

package resolvers

import (
    "github.com/tailor-platform/tailorctl/schema/v2/pipeline"
    "github.com/tailor-platform/tailorctl/schema/v2/common"
)

moBatchPreviewOutput : {
	Name: "moBatchPreviewOutput"
	Fields: [
		{
			Name:  "moBatches"
			Array: true
			Type: {
				Name: "moBatchesList"
				Fields: [
					{Name: "bomId", Type: pipeline.ID},
					{Name: "name", Type: pipeline.String},
					{Name: "quantity", Type: pipeline.Int},
				]
			}
		}
	]
}

previewMoBatch : pipeline.#Resolver & {
    Authorization: pipeline.#AuthInsecure,
    Name:          "previewMoBatch",
    Description: """
        Generates a preview of Manufacturing Order (MO) batches based on total quantity and batch size.
    """,
    Response: {Type: moBatchPreviewOutput}
    Inputs: [
        {Name: "bomId", Type: pipeline.ID, Required: true},
        {Name: "totalQuantity", Type: pipeline.Int, Required: true},
        {Name: "batchSize", Type: pipeline.Int, Required: true},
        {Name: "name", Type: pipeline.String, Required: true},
    ],
    Pipelines: [
        {
            Name:        "generateBatches",
            Description: "Generates batch quantities based on total quantity and batch size.",
            PostHook: common.#Script & {
                Expr: """
					(() => {
					const totalQuantity = context.args.totalQuantity;
					const batchSize = context.args.batchSize;
					const bomId = context.args.bomId;
					const baseName = context.args.name;
					const batches = [];
					let remainingQuantity = totalQuantity;
					let batchNumber = 1;

					while (remainingQuantity > 0) {
						const quantity = remainingQuantity >= batchSize ? batchSize : remainingQuantity;
						batches.push({
							bomId: bomId,
							name: baseName + ' - Batch ' + batchNumber,
							quantity: quantity
						});
						remainingQuantity -= quantity;
						batchNumber++;
					}

					return {moBatches:batches};
					})()
					"""
            },
        },
    ],
}
