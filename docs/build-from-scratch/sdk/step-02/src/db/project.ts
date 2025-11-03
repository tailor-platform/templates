import { db } from "@tailor-platform/tailor-sdk";

export const project = db
  .type("Project", {
    name: db.string().description("Name of the Project"),
    description: db
      .string({ optional: true })
      .description("Description of the project"),
    ...db.fields.timestamps(),
  })