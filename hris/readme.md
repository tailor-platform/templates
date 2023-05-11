## Overview
This HRIS application basically has 4 types:

- `user`: This type stores data about your users. The actual data is managed by the [Directory service](https://platform-frontend-services-docs.vercel.app/guides/directory), and this user type is extended in [Tailor DB](https://platform-frontend-services-docs.vercel.app/guides/tailordb/overview).
- `employee`: This type stores data about your employees. This type extends the `user` type so that you can add fields to manage your employee data.
- `employment`: This type stores data about the employment of your employees. The data is associated with an employee, and access to this data is only available to the employee and Admin user in this app as it includes sensitive information.
- `personalData`: This type stores data about the personal data of your employees. Similar to employment data, access to this data is only available to the employee and Admin user.

In addition to these 4 types in [Tailor DB](https://platform-frontend-services-docs.vercel.app/guides/tailordb/overview), there are other types such as `group`, `role`, etc. used to configure access management. These data are also managed in the [Directory service](https://platform-frontend-services-docs.vercel.app/guides/directory) in the same way as the `user` type.

### Sample GraphQL queries and mutations

Create a new employee record.
```graphql
mutation (
  $employeeCode: String!
  $displayName: String!
  $username: String!
  $secret: String!
  $firstName: String!
  $lastName: String!
  $adminID: ID!
  $permanentID: ID!
  $avatar: String!
  $gid: ID!
  $mobilePhoneNumber: String!
  $workEmail: String!
) {
  addNewEmployee(
    input: {
      employeeCode: $employeeCode
      displayName: $displayName
      username: $username
      secret: $secret
      firstName: $firstName
      lastName: $lastName
      roleInput: [{ id: $adminID }] # ID is defined in your cue file.
      userTypeID: $permanentID # ID is defined in your cue file.
      avatar: $avatar
      groupInput: [{ id: $gid }] # ID is defined in your cue file.
      mobilePhoneNumber: $mobilePhoneNumber
      workEmail: $workEmail
    }
  ) {
    id
  }
}
```

Add personal data to an employee.
```graphql
mutation (
  $employeeID: ID!
  $hireDate: Date!
  $dateOfBirth: Date
  $personalEmail: String!
  $socialSecurityNumber: String!
  $startDate: Date!
  $employmentStatus: String
) {
  addPersonalDataToEmployee(
    input: {
      employeeID: $employeeID
      hireDate: $hireDate
      dateOfBirth: $dateOfBirth
      personalEmail: $personalEmail
      socialSecurityNumber: $socialSecurityNumber
      startDate: $startDate
      employmentStatus: $employmentStatus
    }
  )
}
```

Add employment data to an employee.
```graphql
mutation (
  $payPeriod: String
  $payCurrency: String!
  $effectiveDate: Date
  $employmentType: String
  $employeeID: ID!
  $jobTitle: String!
  $payRate: Int!
) {
  addEmploymentToEmployee(
    input: {
      payPeriod: $payPeriod
      payCurrency: $payCurrency
      effectiveDate: $effectiveDate
      employmentType: $employmentType
      employeeID: $employeeID
      jobTitle: $jobTitle
      payRate: $payRate
    }
  )
}
```

Get group records including user data in the group.
```graphql
query groups {
  groups {
    collection {
      id
      name
      parent {
        name
      }
      users {
        collection {
          id
          displayName
        }
      }
    }
  }
}

```


## Dev instructions

### Deployment

To create the application, see the [Quickstart](https://pf-services-docs-tailorinc.vercel.app/getting-started/quickstart)

### Seeding

To seed the data do:

```sh
tailorctl app login -u ${username} -p ${password}
tailorctl app import -m charts
```

## Demo Apps in Retool
- [HRIS retool demo app Admin-view](https://tailorinc.retool.com/embedded/public/55ba8391-57b5-4679-a1ce-844f33042c19)
- [HRIS retool demo app Staff-view](https://tailorinc.retool.com/embedded/public/788dbc71-d0a6-4ab1-b93e-0fb0639cfbd2)
