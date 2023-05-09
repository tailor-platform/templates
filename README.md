# Deploy this template
To deploy this template, you need tailorctl and a Tailor account.  
If you don’t have a Tailor account, please contact us.

To install tailorctl, you can use homebrew.
```
brew install tailor-platform/tap/tailorctl
```

In tailorctl, please run this command to deploy the template:

```bash
## example tutorial/todo-app
tailorctl template generate -t git+https://github.com/tailor-platform/templates@tutorial/todo-app -o charts
```

Once you run this command, this TODO application will be deployed to your reserved domain, and the GraphQL endpoint will be ready to interact with the Frontend.