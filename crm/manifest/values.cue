package manifest

#app: {
	domain:    string
	namespace: string
}

#subgraph: {
	gateway:   string | *("https://" + #app.domain + "/query")
	tailordb:  string | *("https://tailordb/graphql/" + #app.namespace)
	pipeline:  string | *("https://pipeline/graphql/" + #app.namespace)
	stateflow: string | *("https://stateflow/graphql/" + #app.namespace)
}
