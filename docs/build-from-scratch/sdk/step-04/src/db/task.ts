import { db } from "@tailor-platform/sdk";
import { project } from "./project";
import { user } from "./user";
import { gqlPermissionLoggedIn, permissionLoggedIn } from "../common/permission";

export const task = db
  .type("Task", {
    name: db.string().description("Name of the Task"),
    description: db
      .string({ optional: true })
      .description("Description of the task"),
    projectId: db
      .uuid()
      .description("ID of the project the task belongs to")
      .relation({ type: "n-1", toward: { type: project } }),
    assigneeId: db
      .uuid({ optional: true })
      .description("ID of the user assigned to the task")
      .relation({ type: "n-1", toward: { type: user } }),
    status: db.enum([
      { value: "TODO", description: "To Do status" },
      { value: "IN_PROGRESS", description: "In Progress status" },
      { value: "IN_REVIEW", description: "In Review status" },
      { value: "DONE", description: "Done status" },
      { value: "CANCELED", description: "Canceled status" },
    ]),
    dueDate: db
      .date()
      .description("Due date of the task"),
    ...db.fields.timestamps(),
  })
  .permission(permissionLoggedIn)
  .gqlPermission(gqlPermissionLoggedIn);