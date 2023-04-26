package settings

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	workflow: {{ .Values.workflow.graphqlEndpoint | quote }}
	directory: {{ .Values.directory.graphqlEndpoint | quote }}
	gateway: {{ .Values.gateway.graphqlEndpoint | quote }}
}