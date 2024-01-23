package connector

import (
	"github.com/tailor-platform/tailorctl/schema/v2/common"
	"github.com/tailor-platform/tailorctl/schema/v2/tailordb"
	"github.com/tailor-platform/tailorctl/schema/v2/secretmanager"
)

#Spec: {
	common.#WithKind
	common.#WithVersion
	common.#WithNamespace

	kind: common.#Connector
	connectors: [...#Connector]
}

#Connector: {
	name:        string
	description: string | *""
	parallel:    int32 | *1
	invoker:     #Invoker | null
	driver:      [
			if (driver).type == #DriverType.AwsS3 {#AwsS3Driver},
			if (driver).type == #DriverType.Gcs {#GcsDriver},
			if (driver).type == #DriverType.Graphql {#GraphqlDriver},
	][0]
	if (driver).type == #DriverType.AwsS3 {
		awsS3Driver: (driver)
	}
	if (driver).type == #DriverType.Gcs {
		gcsDriver: (driver)
	}
	if (driver).type == #DriverType.Graphql {
		graphqlDriver: (driver)
	}
	parser: [
		if (parser).type == #ParserType.Csv {#CsvParser},
		if (parser).type == #ParserType.Json {#JsonParser},
	][0]
	if (parser).type == #ParserType.Csv {
		csvParser: (parser)
	}
	if (parser).type == #ParserType.Json {
		jsonParser: (parser)
	}
	loader: [
		if (loader).type == #LoaderType.Graphql {#GraphqlLoader},
	][0]
	if (loader).type == #LoaderType.Graphql {
		graphqlLoader: (loader)
	}
	fields: [...#Field]
	notification: [
			if (notification).type == #NotificationType.None {#NonNotification},
			if (notification).type == #NotificationType.Slack {#SlackNotification},
			if (notification).type == #NotificationType.Email {#EmailNotification},
	][0]
	if (notification).type == #NotificationType.None {
		nonNotification: (notification)
	}
	if (notification).type == #NotificationType.Slack {
		slackNotification: (notification)
	}
	if (notification).type == #NotificationType.Email {
		emailNotification: (notification)
	}
}

#Invoker: {
	userId: string
	attributes: [...common.#UUID]
}

#DriverType: {
	AwsS3:   "awss3"
	Gcs:     "gcs"
	Graphql: "graphql"
}

#LoaderType: {
	Graphql: "graphql"
}

#NotificationType: {
	None:  "none"
	Slack: "slack"
	Email: "email"
}

#ParserType: {
	Csv:  "csv"
	Json: "json"
}

#Compression: {
	None: "none"
	Zip:  "zip"
}

#AwsS3Driver: {
	type:        #DriverType.AwsS3
	bucket:      string & !=""
	prefix:      string | *""
	keyPattern:  string | *""
	compression: #Compression.None | #Compression.Zip | *#Compression.None
	credentials: {
		accessKeyId:     string & !=""
		secretAccessKey: secretmanager.#SecretValue
		region:          string & !=""
		roleArn:         string | *""
	}
}

#GcsDriver: {
	type:        #DriverType.Gcs
	bucket:      string & !=""
	prefix:      string | *""
	keyPattern:  string | *""
	compression: string | *""
}

#GraphqlVariable: [string]: string | int | float | bool | #GraphqlVariable

#GraphqlDriver: {
	type:  #DriverType.Graphql
	url:   string & !=""
	query: string & !=""
	variables: #GraphqlVariable | *null
}

#CsvParser: {
	type:        #ParserType.Csv
	parser:      string | *""
	skipOnError: bool | *false
}

#JsonParser: {
	type:        #ParserType.Json
	parser:      string | *""
	query:      string | *""
	skipOnError: bool | *false
}

#GraphqlLoader: {
	type:            #LoaderType.Graphql
	graphqlEndpoint: string & !=""
	graphqlQuery:    string | *""
	mapping:         string | *""
	check:           string & !=""
	skipOnError:     bool | *false
}

#Field: {
	name:   string & !=""
	config: tailordb.#Field
}

#NonNotification: {
	type: #NotificationType.None
}

#SlackNotification: {
	type:    #NotificationType.Slack
	token:   secretmanager.#SecretValue
	channel: string | *""
	text:    string | *""
}

#EmailNotification: {
	type:    #NotificationType.Email
	to:      string & !=""
	cc:      string | *""
	subject: string | *""
	body:    string | *""
}
