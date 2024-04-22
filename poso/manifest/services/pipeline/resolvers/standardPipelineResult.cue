package resolvers

import (
	"github.com/tailor-platform/tailorctl/schema/v2/pipeline"
)

standardPipelineResult: {
	Name: "standardPipelineResult"
	Fields: [
		{ Name: "result", Type: pipeline.String, Required: false },
		{ Name: "error", Type: pipeline.String, Required: false },
	]
}
