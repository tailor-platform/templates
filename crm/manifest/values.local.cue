@if(local)
package manifest

#app: {
	domain:    "crm.mini.tailor.tech:8000"
	namespace: "crm"
}

#subgraph: {
	gateway:   "http://" + #app.domain + "/query"
	tailordb:  "http://mini.tailor.tech:18002/graphql/" + #app.namespace
	pipeline:  "http://mini.tailor.tech:18004/graphql/" + #app.namespace
	stateflow: "http://mini.tailor.tech:18008/graphql/" + #app.namespace
}
