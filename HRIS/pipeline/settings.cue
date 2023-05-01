package settings

import (
	"{{ .Values.cue.package }}/charts/directory:directories"
)

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	directory: {{ .Values.directory.graphqlEndpoint | quote }}
	gateway: {{ {{ print "https://" .Values.gateway.domain "/query" | quote }} | quote }}
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
