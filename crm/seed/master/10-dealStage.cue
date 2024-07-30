package master

import (
	"tailor.build/template/seed/utils"
)

#DealStage: {
	dealStage1: {
		id: utils.uuid & {_, #type: "dealstage", #value: "1"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 1
		label:        "prospecting"
		name:         "Prospecting"
		type:         "SDR"
		probability:  0
		description:  "Identifying potential customers through research and various lead generation techniques"
		closedWon:    false
		closedLost:   false
	}
	dealStage2: {
		id: utils.uuid & {_, #type: "dealstage", #value: "2"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 2
		label:        "initial_outreach"
		name:         "Initial Outreach"
		type:         "SDR"
		probability:  0.1
		description:  "Contacting prospects through emails, calls, or social media to introduce the company and its offerings"
		closedWon:    false
		closedLost:   false
	}
	dealStage3: {
		id: utils.uuid & {_, #type: "dealstage", #value: "3"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 3
		label:        "qualification"
		name:         "Qualification"
		type:         "SDR"
		probability:  0.2
		description:  "Determining if the prospect meets the criteria for a potential customer (BANT - Budget, Authority, Need, Timeline)"
		closedWon:    false
		closedLost:   false
	}
	dealStage4: {
		id: utils.uuid & {_, #type: "dealstage", #value: "4"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 4
		label:        "discovery_call"
		name:         "Discovery Call"
		type:         "SDR"
		probability:  0.4
		description:  "Engaging in a deeper conversation to understand the prospect's needs, challenges, and objectives"
		closedWon:    false
		closedLost:   false
	}
	dealStage5: {
		id: utils.uuid & {_, #type: "dealstage", #value: "5"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 5
		label:        "discovery_call"
		name:         "Hand-off to Sales"
		type:         "SDR"
		probability:  0.5
		description:  "Scheduling a meeting or demo with a Sales Representative (SR) or Account Executive (AE) if the prospect is qualified"
		closedWon:    true
		closedLost:   false
	}
	dealStage6: {
		id: utils.uuid & {_, #type: "dealstage", #value: "6"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "1"}
		displayOrder: 6
		label:        "deal_lost"
		name:         "Deal Lost"
		type:         "SDR"
		probability:  0
		description:  "Prospect does not move forward after initial contact or qualification"
		closedWon:    false
		closedLost:   true
	}
	dealStage7: {
		id: utils.uuid & {_, #type: "dealstage", #value: "7"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 1
		label:        "sql_identification"
		name:         "SQL Identification"
		type:         "SQL"
		probability:  0.2
		description:  "Confirming the lead is sales-qualified based on predetermined criteria"
		closedWon:    false
		closedLost:   false
	}
	dealStage8: {
		id: utils.uuid & {_, #type: "dealstage", #value: "8"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 2
		label:        "needs_analysis"
		name:         "Needs Analysis"
		type:         "SQL"
		probability:  0.4
		description:  "Conducting a detailed assessment of the prospect’s requirements and pain points"
		closedWon:    false
		closedLost:   false
	}
	dealStage9: {
		id: utils.uuid & {_, #type: "dealstage", #value: "9"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 3
		label:        "solution_presentation"
		name:         "Solution Presentation"
		type:         "SQL"
		probability:  0.5
		description:  "Presenting a tailored solution that addresses the prospect's needs"
		closedWon:    false
		closedLost:   false
	}
	dealStage10: {
		id: utils.uuid & {_, #type: "dealstage", #value: "10"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 4
		label:        "scope_definition"
		name:         "Scope Definition"
		type:         "SQL"
		probability:  0.6
		description:  "Clearly defining the scope of work or products/services to be provided"
		closedWon:    false
		closedLost:   false
	}
	dealStage11: {
		id: utils.uuid & {_, #type: "dealstage", #value: "11"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 5
		label:        "estimate_preparation"
		name:         "Estimate Preparation"
		type:         "SQL"
		probability:  0.7
		description:  "Creating and sending a detailed estimate or proposal to the prospect"
		closedWon:    true
		closedLost:   false
	}
	dealStage12: {
		id: utils.uuid & {_, #type: "dealstage", #value: "12"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "2"}
		displayOrder: 6
		label:        "deal_lost"
		name:         "Deal Lost"
		type:         "SQL"
		probability:  0
		description:  "Prospect does not accept the estimate or proposal"
		closedWon:    false
		closedLost:   true
	}
	dealStage13: {
		id: utils.uuid & {_, #type: "dealstage", #value: "13"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 1
		label:        "estimate_review"
		name:         "Estimate Review"
		type:         "Estimate"
		probability:  0.6
		description:  "Reviewing the estimate with the prospect to ensure all needs and expectations are met"
		closedWon:    false
		closedLost:   false
	}
	dealStage14: {
		id: utils.uuid & {_, #type: "dealstage", #value: "14"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 2
		label:        "negotiation"
		name:         "Negotiation"
		type:         "Estimate"
		probability:  0.7
		description:  "Addressing any concerns or objections and negotiating terms, pricing, and scope"
		closedWon:    false
		closedLost:   false
	}
	dealStage15: {
		id: utils.uuid & {_, #type: "dealstage", #value: "15"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 3
		label:        "contract_signing"
		name:         "Contract Signing"
		type:         "Estimate"
		probability:  0.8
		description:  "Obtaining signatures from all parties to finalize the agreement"
		closedWon:    false
		closedLost:   false
	}
	dealStage16: {
		id: utils.uuid & {_, #type: "dealstage", #value: "16"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 4
		label:        "onboarding"
		name:         "Onboarding"
		type:         "Estimate"
		probability:  1
		description:  "Starting the onboarding process for the new customer, ensuring a smooth transition from sales to delivery"
		closedWon:    true
		closedLost:   false
	}
	dealStage17: {
		id: utils.uuid & {_, #type: "dealstage", #value: "17"}
		dealPipelineId: utils.uuid & {_, #type: "dealpipeline", #value: "3"}
		displayOrder: 5
		label:        "deal_lost"
		name:         "Deal Lost"
		type:         "Estimate"
		probability:  0
		description:  "Prospect does not move forward after estimate review, negotiation, or contract drafting"
		closedWon:    false
		closedLost:   true
	}
}

DealStage: {
	items: [
		for k, v in #DealStage {
			v
		},
	]
}
