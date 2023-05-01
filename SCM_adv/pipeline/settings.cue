package settings

services: {
	db: {{ .Values.tailordb.graphqlEndpoint | quote }}
	directory: {{ .Values.directory.graphqlEndpoint | quote }}
	gateway: {{ {{ print "https://" .Values.gateway.domain "/query" | quote }} | quote }}
}