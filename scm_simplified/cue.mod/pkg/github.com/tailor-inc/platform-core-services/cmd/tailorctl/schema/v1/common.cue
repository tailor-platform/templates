package common

#UUID:           =~"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
#IdentifierName: =~"^[0-9a-zA-Z-_]{2,}$"
#URL:            =~"^https?:\/\/\\w+(\\.\\w+)*(:[0-9]+)?.*?$"

#GraphqlMutationSdl: {
	query:      string
	variables?: {[string]: _} | null
}
