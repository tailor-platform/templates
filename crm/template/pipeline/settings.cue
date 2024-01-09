package settings

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	gateway: {{ .Values.gateway.graphqlEndpoint | quote }}
}
