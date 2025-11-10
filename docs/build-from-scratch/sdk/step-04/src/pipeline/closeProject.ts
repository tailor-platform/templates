import { createResolver, t } from "@tailor-platform/tailor-sdk";
import { getDB } from "../generated/tailordb";

export default createResolver({
  name: "closeProject",
  operation: "mutation",
  input: t.type({
    id: t.string(),
  }),
  body: async (context) => {

    const db = getDB("main-db");

   // 1. Fetch the project
    const project = await db
        .selectFrom("Project")
        .selectAll()
        .where("id", "=", context.input.id)
        .executeTakeFirst();

    if (!project) {
        throw new Error(`Project not found, expected:1 got:0`);
    }

    if (project.status === "CANCELED") {
        return { result: "Project is already closed." };
    }

    // 2. Get all incomplete tasks for the project
    const incompleteTasks = await db
        .selectFrom("Task")
        .selectAll()
        .where("projectId", "=", context.input.id)
        .where("status", "!=", "DONE")
        .execute();

    // 3. Start a transaction
    await db.transaction().execute(async (trx: any) => {
        // Mark all incomplete tasks as canceled
        for (const task of incompleteTasks) {
        await trx
            .updateTable("Task")
            .set({ status: "CANCELED" })
            .where("id", "=", task.id)
            .execute();
        }
        // Close the project
        await trx
        .updateTable("Project")
        .set({ status: "CLOSED" })
        .where("id", "=", context.input.id)
        .execute();
    });
    return {  result: `${context.input.id} project has been closed. All incomplete tasks are marked as canceled.`, };
  },
  output: t.type({
    result: t.string({ optional: true }),
  }),
});
