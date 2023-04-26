# Client Portal

This template allows you to create a Client Portal application.


## Dev instructions

### Preparation

Before anything, change the seed UUID in [values.example.yaml](values.example.yaml):

```yaml
seed:
  key: "<newly generated UUID here>"
```

### Deployment

To create the application, see the [Quickstart](https://pf-services-docs-tailorinc.vercel.app/getting-started/quickstart)

### Seeding

To seed the data do:

```sh
tailorctl app login -u clientportal-admin -p 'Pa55w0rd'
tailorctl app import -m charts/graphql_seed.cue
```


## Apps in Retool

- [Client view](https://tailorinc.retool.com/editor/0b249efc-de53-11ed-a861-63b9cb6368eb/app%20templates/Client%20Portal%20(client%20view))
- [Manager view](https://tailorinc.retool.com/apps/68bcf0f0-c166-11ed-a96f-dbc7e6501446/app%20templates/Client%20Portal%20(manager%20view))

