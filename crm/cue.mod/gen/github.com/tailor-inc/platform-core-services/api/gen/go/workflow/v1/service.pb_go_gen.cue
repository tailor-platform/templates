// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tailor-inc/platform-core-services/api/gen/go/workflow/v1

package workflowv1

import "google.golang.org/protobuf/types/known/timestamppb"

#ActivateWorkflowRequest: {
	id?: string @go(Id) @protobuf(1,bytes,opt,proto3)
	WorkflowAdmins?: [...string] @go(,[]string) @protobuf(2,bytes,rep,proto3)
	WorkflowViewers?: [...string] @go(,[]string) @protobuf(3,bytes,rep,proto3)
}

#ActivateWorkflowResponse: {
	success?: bool                          @go(Success) @protobuf(1,varint,opt,proto3)
	status?:  null | #WorkflowServiceStatus @go(Status,*WorkflowServiceStatus) @protobuf(2,bytes,opt,proto3)
}

#WorkflowServiceStatusRequest: {
	id?: string @go(Id) @protobuf(1,bytes,opt,proto3)
}

#WorkflowServiceStatus: {
	id?: string @go(Id) @protobuf(1,bytes,opt,proto3)
	WorkflowAdmins?: [...string] @go(,[]string) @protobuf(3,bytes,rep,proto3)
	WorkflowViewers?: [...string] @go(,[]string) @protobuf(4,bytes,rep,proto3)
}

#WorkflowServiceStatusResponse: {
	active?: bool                          @go(Active) @protobuf(1,varint,opt,proto3)
	status?: null | #WorkflowServiceStatus @go(Status,*WorkflowServiceStatus) @protobuf(2,bytes,opt,proto3)
}

#DeActivateWorkflowRequest: {
	id?: string @go(Id) @protobuf(1,bytes,opt,proto3)
}

#DeActivateWorkflowResponse: {
	success?: bool @go(Success) @protobuf(1,varint,opt,proto3)
}

#CreateWorkflowRequest: {
	id?:         null | string @go(Id,*string) @protobuf(4,bytes,opt,proto3,oneof)
	name?:       string        @go(Name) @protobuf(1,bytes,opt,proto3)
	identifier?: string        @go(Identifier) @protobuf(2,bytes,opt,proto3)
	steps?: [...null | #Step] @go(Steps,[]*Step) @protobuf(3,bytes,rep,proto3)
	start_at?: null | timestamppb.#Timestamp @go(StartAt,*timestamppb.Timestamp) @protobuf(101,bytes,opt,json=startAt,proto3)
	end_at?:   null | timestamppb.#Timestamp @go(EndAt,*timestamppb.Timestamp) @protobuf(102,bytes,opt,json=endAt,proto3)
}

#CreateWorkflowResponse: {
	workflow?: null | #Workflow @go(Workflow,*Workflow) @protobuf(1,bytes,opt,proto3)
}

#GetWorkflowRequest: {
	workflow_id?: string @go(WorkflowId) @protobuf(1,bytes,opt,json=workflowId,proto3)
}

#GetWorkflowResponse: {
	workflow?: null | #Workflow @go(Workflow,*Workflow) @protobuf(1,bytes,opt,proto3)
}

#SearchWorkflowRequest: {
	search_keys?: {[string]: string} @go(SearchKeys,map[string]string) @protobuf(1,map[bytes]bytes,rep,json=searchKeys,proto3)
}

#SearchWorkflowResponse: {
	workflows?: [...null | #Workflow] @go(Workflows,[]*Workflow) @protobuf(1,bytes,rep,proto3)
}

#GetWorkflowsRequest: {
	ids?: [...string] @go(Ids,[]string) @protobuf(1,bytes,rep,proto3)
	page?:  null | int64 @go(Page,*int64) @protobuf(2,varint,opt,proto3,oneof)
	limit?: null | int64 @go(Limit,*int64) @protobuf(3,varint,opt,proto3,oneof)
}

#GetWorkflowsResponse: {
	workflows?: [...null | #Workflow] @go(Workflows,[]*Workflow) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
	page?:  int64 @go(Page) @protobuf(3,varint,opt,proto3)
	limit?: int64 @go(Limit) @protobuf(4,varint,opt,proto3)
}

#CreateTicketRequest: {
	identifier?:  string        @go(Identifier) @protobuf(1,bytes,opt,proto3)
	creator?:     string        @go(Creator) @protobuf(2,bytes,opt,proto3)
	workflow_id?: string        @go(WorkflowId) @protobuf(3,bytes,opt,json=workflowId,proto3)
	name?:        null | string @go(Name,*string) @protobuf(4,bytes,opt,proto3,oneof)
}

#CreateTicketResponse: {
	ticket?: null | #Ticket @go(Ticket,*Ticket) @protobuf(1,bytes,opt,proto3)
}

#CreateTicketsResponse: {
	tickets?: [...null | #Ticket] @go(Tickets,[]*Ticket) @protobuf(1,bytes,rep,proto3)
}

#CreateTicketsRequest: {
	targets?: [...null | #CreateTicketRequest] @go(Targets,[]*CreateTicketRequest) @protobuf(1,bytes,rep,proto3)
}

#GetTicketRequest: {
	ticket_id?: string @go(TicketId) @protobuf(1,bytes,opt,json=ticketId,proto3)
}

#GetTicketResponse: {
	ticket?: null | #Ticket @go(Ticket,*Ticket) @protobuf(1,bytes,opt,proto3)
}

#GetTicketsRequest: {
	ticket_ids?: [...string] @go(TicketIds,[]string) @protobuf(1,bytes,rep,json=ticketIds,proto3)
	workflow_id?: string @go(WorkflowId) @protobuf(2,bytes,opt,json=workflowId,proto3)
	page?:        int64  @go(Page) @protobuf(3,varint,opt,proto3)
	limit?:       int64  @go(Limit) @protobuf(4,varint,opt,proto3)
}

#GetTicketsResponse: {
	tickets?: [...null | #Ticket] @go(Tickets,[]*Ticket) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
}

#PunchTicketRequest: {
	ticket_id?: string @go(TicketId) @protobuf(1,bytes,opt,json=ticketId,proto3)
	action?:    string @go(Action) @protobuf(2,bytes,opt,proto3)
}

#PunchTicketResponse: {
	result?: bool           @go(Result) @protobuf(1,varint,opt,proto3)
	ticket?: null | #Ticket @go(Ticket,*Ticket) @protobuf(2,bytes,opt,proto3)
}

#PunchTicketsRequest: {
	targets?: [...null | #PunchTicketRequest] @go(Targets,[]*PunchTicketRequest) @protobuf(1,bytes,rep,proto3)
	skipError?: bool @go(SkipError) @protobuf(2,varint,opt,proto3)
}

#PunchTicketsResponse: {
	result?: bool @go(Result) @protobuf(1,varint,opt,proto3)
	tickets?: [...null | #Ticket] @go(Tickets,[]*Ticket) @protobuf(2,bytes,rep,proto3)
}

#ApprovalHistoryRequest: {
	id?: string @go(Id) @protobuf(1,bytes,opt,proto3)
}

#ApprovalHistoryResponse: {
	approvalHistory?: null | #ApprovalHistory @go(ApprovalHistory,*ApprovalHistory) @protobuf(1,bytes,opt,proto3)
}

#ApprovalHistoriesRequest: {
	ticket_id?: string @go(TicketId) @protobuf(1,bytes,opt,json=ticketId,proto3)
}

#ApprovalHistoriesResponse: {
	approvalHistories?: [...null | #ApprovalHistory] @go(ApprovalHistories,[]*ApprovalHistory) @protobuf(1,bytes,rep,proto3)
}

#GetAssignedTicketsRequest: {
	approver_id?: string @go(ApproverId) @protobuf(1,bytes,opt,json=approverId,proto3)
	page?:        int32  @go(Page) @protobuf(2,varint,opt,proto3)
	limit?:       int32  @go(Limit) @protobuf(3,varint,opt,proto3)
}

#GetAssignedTicketsResponse: {
	tickets?: [...null | #Ticket] @go(Tickets,[]*Ticket) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
}

#GetAssignedWorkflowsRequest: {
	approver_id?: string @go(ApproverId) @protobuf(1,bytes,opt,json=approverId,proto3)
	page?:        int32  @go(Page) @protobuf(2,varint,opt,proto3)
	limit?:       int32  @go(Limit) @protobuf(3,varint,opt,proto3)
}

#GetRespondedWorkflowsRequest: {
	approver_id?: string @go(ApproverId) @protobuf(1,bytes,opt,json=approverId,proto3)
	page?:        int32  @go(Page) @protobuf(2,varint,opt,proto3)
	limit?:       int32  @go(Limit) @protobuf(3,varint,opt,proto3)
}

#GetRespondedTicketsRequest: {
	approver_id?: string @go(ApproverId) @protobuf(1,bytes,opt,json=approverId,proto3)
	page?:        int32  @go(Page) @protobuf(2,varint,opt,proto3)
	limit?:       int32  @go(Limit) @protobuf(3,varint,opt,proto3)
}

#GetRespondedTicketsResponse: {
	tickets?: [...null | #Ticket] @go(Tickets,[]*Ticket) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
}

#GetAssignedWorkflowsResponse: {
	workflows?: [...null | #Workflow] @go(Workflows,[]*Workflow) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
}

#GetRespondedWorkflowsResponse: {
	workflows?: [...null | #Workflow] @go(Workflows,[]*Workflow) @protobuf(1,bytes,rep,proto3)
	total?: int64 @go(Total) @protobuf(2,varint,opt,proto3)
}