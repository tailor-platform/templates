# Deploy the app template

To deploy our app templates, you need tailorctl and a Tailor account.
If you don’t have a Tailor account,
please [contact us](https://form.typeform.com/to/QONhVIuj?typeform-source=www.tailor.tech).

## Prerequisites

To install tailorctl and other dependencies, you can use homebrew.

```
brew install tailor-platform/tap/tailorctl
brew install hashicorp/tap/terraform
```

For more details, please visit our [documentation](https://docs.tailor.tech/getting-started/quickstart/terraform).

To get started with our app templates follow the steps below:

## Quick Start

### 1. Clone our app template

```bash
git clone git@github.com:tailor-platform/templates.git
cd templates/docs/sample-inventory-management
```

### 2. Run the following commands to deploy the app

```bash
terraform init
terraform apply
```

### 3. Get the access token to use the GraphQL API in the playground

```bash
tailorctl workspace machineuser token -a ims -m admin-machine-user
```

Please set the token in the Headers section of the playground as follows:
```json
{
  "Authorization": "bearer ${your_access_token}"
}
```

### 5. Finally, open the GraphQL playground to run queries

```
tailorctl workspace app open -n ims
```
