globalThis.main = async function (args) {
    const client = new tailordb.Client({
        namespace: "project-management-db",
    });
    await client.connect();
    try {
        const project = await client.queryObject(`SELECT * FROM Project WHERE id = '${args.projectId}'`);

        if (project.rowCount === 0) {
            throw new Error(`Project not found, expected:1 got:${project.rowCount}`)
        }
        
        // Check if project is already closed
        if (project.rows[0].status === 'CLOSED') {
            return {
              message: "Project is already closed.",
            };
        }

        // Get all incomplete tasks for the project
        const incompleteTasks = await client.queryObject(`SELECT * FROM Task WHERE projectId = '${args.projectId}' AND status != 'DONE'`);

        const transaction = client.createTransaction("update_project_and_tasks");
        try {
            await transaction.begin();
            // Mark all incomplete tasks as canceled
            for (const task of incompleteTasks.rows) {
                await transaction.queryObject(`UPDATE Task SET status = 'CANCELED' WHERE id = '${task.id}'`);
            }
            // Close the project
            await transaction.queryObject(`UPDATE Project SET status = 'CLOSED' WHERE id = '${args.projectId}'`);
            await transaction.commit();
           
        } catch (e) {
            throw new Error(`update_project_and_tasks failed with error:${e}\n${e.cause}`)
        }

        return {
          message: args.projectId + " project has been closed. All incomplete tasks are marked as canceled.",
        };
        
    } finally {
        await client.end();
    }

}

