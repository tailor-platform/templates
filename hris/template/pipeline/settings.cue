package settings

import (
	"tailor.build/hris/charts/directory:directories"
)

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	directory: {{ .Values.directory.graphqlEndpoint | quote }}
	gateway: {{ .Values.gateway.graphqlEndpoint | quote }}
}


permissions: {
	read: [
		{id: directories.roleMap.Admin.id, permit:"allow"},
	],
	update: [
		{id: directories.roleMap.Admin.id, permit:"allow"},
	],
	delete: [
		{id: directories.roleMap.Admin.id, permit:"allow"},
	]
}
