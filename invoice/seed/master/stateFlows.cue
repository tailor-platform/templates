package master

import (
	"tailor.build/template/seed/utils"
)

#StateFlows: {
	ReviewFlow1: {
		id: utils.uuid & {_, #type: "ReviewFlow1", #value: "1"}
		name: "invoiceReviewFlow"
		stateTransitionModels: [
			{
				name: "ManagerReview"
				approvers: [
					{id: utils.uuid & {_, #type: "roles", #value: "Admin"}},
					{id: utils.uuid & {_, #type: "roles", #value: "Manager"}},
				]
				transitions: [{
					action:      "approve"
					destination: "CustomerReview"
				}]
			},
			{
				name: "CustomerReview"
				approvers: [
					{id: utils.uuid & {_, #type: "roles", #value: "Admin"}},
					{id: utils.uuid & {_, #type: "roles", #value: "Customer"}},
				]
				transitions: [{
					action:      "approve"
					destination: "AllApproved"
				}]
			},
			{
				name: "AllApproved"
			},
		]
	}
}

StateFlow: {
	items: [
		for k, v in #StateFlows {
			v
		},
	]
	query: """
		mutation ($input: NewStateFlowRequestInput){
		    newStateFlow(input: $input) {
		        id
		    }
		}
		"""
}
