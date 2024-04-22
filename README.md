# Deploy the app template
To deploy our app templates, you need tailorctl and a Tailor account.  
If you don’t have a Tailor account, please [contact us](https://form.typeform.com/to/QONhVIuj?typeform-source=www.tailor.tech).


To install tailorctl, you can use homebrew.
```
brew install tailor-platform/tap/tailorctl
```

For more details, please visit our [documentation](https://docs.tailor.tech/getting-started/quickstart).

To get started with our app templates follow the steps below:

1. Clone our app templates and install dependencies 

```
git clone git@github.com:tailor-platform/templates.git
cd templates
pnpm i
brew install coreutils yq cue gh tailor-platform/tap/tailorctl
```

2. Choose an app template 

```
cd ${app_template}
```

3. Run the following commands to deploy the app

```
make init
make apply
make seed
```

4. Get the access token to use the GraphQL API in the playground

```
make machine-token
```

Please set the token in the Headers section of the playground as follows:
{
  "Authorization": "bearer ${your_access_token}"
}

5. Finally, open the GraphQL playground to run  queries

```
make app
```
