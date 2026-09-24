import {
  db,
  unsafeAllowAllGqlPermission,
  unsafeAllowAllTypePermission,
} from "@tailor-platform/sdk";

export const user = db
  .table("User", {
    name: db.string().description("Name of the user"),
    email: db.string().unique().description("Email address of the user"),
    role: db.enum(["MANAGER", "STAFF"]),
    ...db.fields.timestamps(),
  })
  .permission(unsafeAllowAllTypePermission)
  .gqlPermission(unsafeAllowAllGqlPermission);
