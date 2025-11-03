import { db } from "@tailor-platform/tailor-sdk";
import { project } from "./project";

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
    ...db.fields.timestamps(),
  })