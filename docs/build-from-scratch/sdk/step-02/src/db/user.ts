import { db } from "@tailor-platform/sdk";
import { gqlPermissionLoggedIn, permissionLoggedIn } from "../common/permission";

export const user = db
  .type("User", {
    name: db.string().description("Name of the user"),
    email: db.string().unique().description("Email address of the user"),
    role: db.enum(["MANAGER", "STAFF", "ADMIN"]),
    ...db.fields.timestamps(),
  })
  .permission(permissionLoggedIn)
  .gqlPermission(gqlPermissionLoggedIn);
