package ruleengine

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
)

#Spec: {
	common.#WithKind
	common.#WithVersion

	kind: common.#RuleEngine
	rules: [...#Rule]
	functions: [...#Function]
}

#Rule: {
	name:         string & !=""
	description:  string | *""
	eventType:    string
	condition:    string | *"true"
	functionName: string
}

#Function: {
	name:        string & !=""
	description: string | *""
	runtime:     string & !=""
	environment: [string]: string | *{}
	sourceUrl: string | *""
}
