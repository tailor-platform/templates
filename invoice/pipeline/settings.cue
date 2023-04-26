package settings

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	stateflow: {{ .Values.stateflow.graphqlEndpoint | quote }}
	directory: {{ .Values.directory.graphqlEndpoint | quote }}
	gateway: {{ .Values.gateway.graphqlEndpoint | quote }}
}
