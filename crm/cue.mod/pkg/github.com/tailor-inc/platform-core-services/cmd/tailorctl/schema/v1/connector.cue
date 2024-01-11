package connector

import v1 "github.com/tailor-inc/platform-core-services/api/gen/go/tailordb/v1:tailordbv1"

#Namespace: {
	id?:          string
	name?:        string
	description?: string
}

#Connector: {
	namespace?: null | #Namespace
	manifest?: [...null | #Manifest]
}

#Manifest: {
	id?:      string
	name?:    string
	invoker?: null | #Invoker
	parallel: int
	driver:   #AwsS3Driver | #GCSDriver | #GraphqlDriver
	parser:   #CsvParser | #JsonParser
	loader:   #GraphqlLoader
	fields?: [...null | #Field]
	notification?: null | #SlackNotification | #EmailNotification
}

#Invoker: {
	userId?:         string
	organizationId?: string
	roles?: [...string]
	groups?: [...string]
	attributeId?: [...string]
}

#AWSCredentials: {
	accessKeyId?:     string
	secretAccessKey?: string
	region?:          string
	roleArn?:         string
}

#CompressionTypeNone: "none"
#CompressionTypeGzip: "gzip"

#AwsS3Driver: {
	type:         "awss3"
	bucket?:      string
	prefix?:      string
	keyPattern?:  string
	compression?: #CompressionTypeNone | #CompressionTypeGzip
	credentials?: null | #AWSCredentials
}

#GCSDriver: {
	type:         "gcs"
	bucket?:      string
	prefix?:      string
	keyPattern?:  string
	compression?: string
}

#GraphqlDriver: {
	type:   "graphql"
	url?:   string
	query?: string
}

#CsvParser: {
	type:         "csv"
	parser?:      string
	skipOnError?: bool
}

#JsonParser: {
	type:         "json"
	parser?:      string
	skipOnError?: bool
}

#GraphqlLoader: {
	type:             "graphql"
	graphqlEndpoint?: string
	graphqlQuery?:    string
	mapping?:         string
	check?:           string
	skipOnError?:     bool
}

#Field: {
	name?:   string
	config?: null | v1.#FieldConfig
}

#SlackNotification: {
	type:    "slack"
	token:   string
	channel: string
	text:    string
}

#EmailNotification: {
	type:    "email"
	to:      string
	cc:      string
	subject: string
	body:    string
}
