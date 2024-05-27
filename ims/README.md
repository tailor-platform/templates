# BASE TEMPLATE FOR V2

1. Copy and paste this template
2. In the folder search for the string "base-template" and replace it for the name of the template
3. Once you publish the project run `make seed` for local deployment or `node ./scripts/seed.mjs` for remote deployment seeding.
4. If you want add a custom query in the seed file do it like this:
```
TableName: {
	items: [
		for k, v in #TableName {
			v
		},
	],
    query: """
    mutation{
        blablaCustomQuery(input: CustomQueryInput!){
            id
        }
    }
    """
}
```
5. If needed, configure the auth server in services/auth/dev.auth.cue
