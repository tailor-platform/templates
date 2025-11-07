import { db } from "@tailor-platform/tailor-sdk";
import { gqlPermissionLoggedIn, permissionLoggedIn } from "../common/permission";

export const project = db
  .type("Project", {
    name: db.string().description("Name of the Project"),
    description: db
      .string({ optional: true })
      .description("Description of the project"),
    status: db.enum(
      { value: "PLANNING", description: "Planning status" },
      { value: "IN_PROGRESS", description: "In Progress status" },
      { value: "ON_HOLD", description: "On hold status" },
      { value: "COMPLETED", description: "Completed status" },
      { value: "CANCELED", description: "Canceled status" },
      { value: "CLOSED", description: "Closed status" },
    ),
    startDate: db
      .date()
      .description("Start date of the project"),
    endDate: db
      .date({ optional: true })
      .description("End date of the project"),
    ...db.fields.timestamps(),
  })
  .permission(permissionLoggedIn)
  .gqlPermission(gqlPermissionLoggedIn);