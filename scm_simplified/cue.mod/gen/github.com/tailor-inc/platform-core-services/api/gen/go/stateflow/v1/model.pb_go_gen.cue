// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tailor-inc/platform-core-services/api/gen/go/stateflow/v1

package stateflowv1

import "google.golang.org/protobuf/types/known/timestamppb"

#StateFlowEventType: int32 // #enumStateFlowEventType

#enumStateFlowEventType:
	#StateFlowEventType_STATEFLOW_CREATED |
	#StateFlowEventType_STATE_CREATED |
	#StateFlowEventType_STATE_TRANSITION

#values_StateFlowEventType: {
	StateFlowEventType_STATEFLOW_CREATED: #StateFlowEventType_STATEFLOW_CREATED
	StateFlowEventType_STATE_CREATED:     #StateFlowEventType_STATE_CREATED
	StateFlowEventType_STATE_TRANSITION:  #StateFlowEventType_STATE_TRANSITION
}

#StateFlowEventType_STATEFLOW_CREATED: #StateFlowEventType & 0
#StateFlowEventType_STATE_CREATED:     #StateFlowEventType & 1
#StateFlowEventType_STATE_TRANSITION:  #StateFlowEventType & 2

#Namespace: {
	name?: string @go(Name) @protobuf(1,bytes,opt,proto3)
	admins?: [...string] @go(Admins,[]string) @protobuf(2,bytes,rep,proto3)
	viewers?: [...string] @go(Viewers,[]string) @protobuf(3,bytes,rep,proto3)
}

// Approver
#Approver: {
	id?:        string @go(Id) @protobuf(1,bytes,opt,proto3)
	condition?: string @go(Condition) @protobuf(2,bytes,opt,proto3)
}

// Transition
#Transition: {
	action?:      string @go(Action) @protobuf(1,bytes,opt,proto3)
	destination?: string @go(Destination) @protobuf(2,bytes,opt,proto3)
}

// StateFlow
#StateFlow: {
	id?:   string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?: string @go(Name) @protobuf(2,bytes,opt,proto3)
	state_transition_models?: [...null | #StateTransitionModel] @go(StateTransitionModels,[]*StateTransitionModel) @protobuf(3,bytes,rep,json=stateTransitionModels,proto3)
	startAt?:   null | timestamppb.#Timestamp @go(StartAt,*timestamppb.Timestamp) @protobuf(101,bytes,opt,name=start_at,json=startAt,proto3,oneof)
	endAt?:     null | timestamppb.#Timestamp @go(EndAt,*timestamppb.Timestamp) @protobuf(102,bytes,opt,name=end_at,json=endAt,proto3,oneof)
	createdAt?: null | timestamppb.#Timestamp @go(CreatedAt,*timestamppb.Timestamp) @protobuf(103,bytes,opt,name=created_at,json=createdAt,proto3)
}

// StateFlow Step
#StateTransitionModel: {
	name?:        string @go(Name) @protobuf(1,bytes,opt,proto3)
	description?: string @go(Description) @protobuf(2,bytes,opt,proto3)
	approvers?: [...null | #Approver] @go(Approvers,[]*Approver) @protobuf(3,bytes,rep,proto3)
	transitions?: [...null | #Transition] @go(Transitions,[]*Transition) @protobuf(4,bytes,rep,proto3)
}

// State is the current state of stateflow state
#State: {
	id?:           string                        @go(Id) @protobuf(1,bytes,opt,proto3)
	name?:         string                        @go(Name) @protobuf(2,bytes,opt,proto3)
	resourceId?:   string                        @go(ResourceId) @protobuf(3,bytes,opt,name=resource_id,json=resourceId,proto3)
	currentState?: string                        @go(CurrentState) @protobuf(4,bytes,opt,name=current_state,json=currentState,proto3)
	stateFlow?:    null | #StateFlow             @go(StateFlow,*StateFlow) @protobuf(5,bytes,opt,name=state_flow,json=stateFlow,proto3)
	creatorMeta?:  null | #CreatorMeta           @go(CreatorMeta,*CreatorMeta) @protobuf(6,bytes,opt,name=creator_meta,json=creatorMeta,proto3)
	createdAt?:    null | timestamppb.#Timestamp @go(CreatedAt,*timestamppb.Timestamp) @protobuf(100,bytes,opt,name=created_at,json=createdAt,proto3)
	updatedAt?:    null | timestamppb.#Timestamp @go(UpdatedAt,*timestamppb.Timestamp) @protobuf(102,bytes,opt,name=updated_at,json=updatedAt,proto3,oneof)
	expireAt?:     null | timestamppb.#Timestamp @go(ExpireAt,*timestamppb.Timestamp) @protobuf(101,bytes,opt,name=expire_at,json=expireAt,proto3)
}

#CreatorMeta: {
	organizationId?: string @go(OrganizationId) @protobuf(1,bytes,opt,name=organization_id,json=organizationId,proto3)
	roles?: [...string] @go(Roles,[]string) @protobuf(2,bytes,rep,proto3)
	groups?: [...string] @go(Groups,[]string) @protobuf(3,bytes,rep,proto3)
}

// State Transition history
#StateHistory: {
	id?:        string                        @go(Id) @protobuf(1,bytes,opt,proto3)
	state?:     string                        @go(State) @protobuf(2,bytes,opt,proto3)
	action?:    string                        @go(Action) @protobuf(3,bytes,opt,proto3)
	approver?:  string                        @go(Approver) @protobuf(4,bytes,opt,proto3)
	createdAt?: null | timestamppb.#Timestamp @go(CreatedAt,*timestamppb.Timestamp) @protobuf(100,bytes,opt,name=created_at,json=createdAt,proto3)
}

#StateFlowEvent: {
	eventType?:   #StateFlowEventType @go(EventType) @protobuf(1,varint,opt,name=event_type,json=eventType,proto3,enum=stateflow.v1.StateFlowEventType)
	stateFlowId?: string              @go(StateFlowId) @protobuf(2,bytes,opt,name=state_flow_id,json=stateFlowId,proto3)
	stateId?:     string              @go(StateId) @protobuf(3,bytes,opt,name=state_id,json=stateId,proto3)

	// Types that are assignable to Detail:
	//
	//	*StateFlowEvent_StateFlowCreated
	//	*StateFlowEvent_StateCreated
	//	*StateFlowEvent_StateTransition
	Detail: _#isStateFlowEvent_Detail
}

_#isStateFlowEvent_Detail: _

#StateFlowEvent_StateFlowCreated: {
	stateFlowCreated?: null | #StateFlowCreated @go(StateFlowCreated,*StateFlowCreated) @protobuf(4,bytes,opt,name=state_flow_created,json=stateFlowCreated,proto3,oneof)
}

#StateFlowEvent_StateCreated: {
	stateCreated?: null | #StateCreated @go(StateCreated,*StateCreated) @protobuf(5,bytes,opt,name=state_created,json=stateCreated,proto3,oneof)
}

#StateFlowEvent_StateTransition: {
	stateTransition?: null | #StateTransition @go(StateTransition,*StateTransition) @protobuf(6,bytes,opt,name=state_transition,json=stateTransition,proto3,oneof)
}

#StateFlowCreated: {
	name?: string @go(StateFlowName) @protobuf(1,bytes,opt,name=state_flow_name,json=stateFlowName,proto3)
}

#StateCreated: {
	name?:       string @go(StateName) @protobuf(1,bytes,opt,name=state_name,json=stateName,proto3)
	resourceId?: string @go(ResourceId) @protobuf(2,bytes,opt,name=resource_id,json=resourceId,proto3)
}

#StateTransition: {
	approverId?:    string @go(ApproverId) @protobuf(1,bytes,opt,name=approver_id,json=approverId,proto3)
	action?:        string @go(Action) @protobuf(2,bytes,opt,proto3)
	prevStateName?: string @go(PrevStateName) @protobuf(4,bytes,opt,name=prev_state_name,json=prevStateName,proto3)
	newStateName?:  string @go(NewStateName) @protobuf(6,bytes,opt,name=new_state_name,json=newStateName,proto3)
}