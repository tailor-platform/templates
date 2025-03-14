```
terraform init
terraform apply
```

```
mutation registerUser {
  registerUser(input: {
    name: "remiposo"
  }) {
    success
  }
}

query users {
  users {
    edges {
      node {
        id
        name
        createdAt
      }
    }
  }
}
```
