// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tailor-inc/platform-core-services/api/gen/go/directory/v1

package directoryv1

#Organization: {
	id?:   string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?: string @go(Name) @protobuf(2,bytes,opt,proto3)
}

#Group: {
	id?:                 string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?:               string @go(Name) @protobuf(2,bytes,opt,proto3)
	code?:               string @go(Code) @protobuf(3,bytes,opt,proto3)
	representativeRole?: string @go(RepresentativeRole) @protobuf(4,bytes,opt,name=representative_role,json=representativeRole,proto3)
	baseRole?:           string @go(BaseRole) @protobuf(5,bytes,opt,name=base_role,json=baseRole,proto3)
	parentId?:           string @go(ParentId) @protobuf(6,bytes,opt,name=parent_id,json=parentId,proto3)
	children?: [...null | #Group] @go(Children,[]*Group) @protobuf(7,bytes,rep,proto3)
	users?: [...null | #User] @go(Users,[]*User) @protobuf(8,bytes,rep,proto3)
}

#UserType: {
	id?:   string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?: string @go(Name) @protobuf(2,bytes,opt,proto3)
}

#UserProfile: {
	employeeCode?: string @go(EmployeeCode) @protobuf(1,bytes,opt,name=employee_code,json=employeeCode,proto3)
	userTypeId?:   string @go(UserTypeId) @protobuf(2,bytes,opt,name=user_type_id,json=userTypeId,proto3)
}

#User: {
	id?:          string              @go(Id) @protobuf(1,bytes,opt,proto3)
	username?:    string              @go(Username) @protobuf(2,bytes,opt,proto3)
	displayName?: string              @go(DisplayName) @protobuf(3,bytes,opt,name=display_name,json=displayName,proto3)
	secret?:      string              @go(Secret) @protobuf(4,bytes,opt,proto3)
	userProfile?: null | #UserProfile @go(UserProfile,*UserProfile) @protobuf(5,bytes,opt,name=user_profile,json=userProfile,proto3)
	roles?: [...string] @go(Roles,[]string) @protobuf(6,bytes,rep,proto3)
	groups?: [...string] @go(Groups,[]string) @protobuf(7,bytes,rep,proto3)
}

#Role: {
	id?:          string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?:        string @go(Name) @protobuf(2,bytes,opt,proto3)
	roleClassId?: string @go(RoleClassId) @protobuf(3,bytes,opt,name=role_class_id,json=roleClassId,proto3)
	policies?: [...string] @go(Policies,[]string) @protobuf(4,bytes,rep,proto3)
}

#RoleClass: {
	id?:   string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?: string @go(Name) @protobuf(2,bytes,opt,proto3)
}

#Policy: {
	id?:      string @go(Id) @protobuf(1,bytes,opt,proto3)
	name?:    string @go(Name) @protobuf(2,bytes,opt,proto3)
	service?: string @go(Service) @protobuf(3,bytes,opt,proto3)
	permit?:  string @go(Permit) @protobuf(4,bytes,opt,proto3)
	actions?: [...string] @go(Actions,[]string) @protobuf(5,bytes,rep,proto3)
	resources?: [...string] @go(Resources,[]string) @protobuf(6,bytes,rep,proto3)
	priority?:     int32  @go(Priority) @protobuf(7,varint,opt,proto3)
	condition?:    string @go(Condition) @protobuf(8,bytes,opt,proto3)
	roleId?:       string @go(RoleId) @protobuf(9,bytes,opt,name=role_id,json=roleId,proto3)
	passwordRule?: int32  @go(PasswordRule) @protobuf(10,varint,opt,name=password_rule,json=passwordRule,proto3)
}
