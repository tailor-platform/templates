import { getDB, getDbClient, DbInfoSchema, QueryReturnType, DB } from "./db";
import { z } from 'zod';

// ----------------------------------------
// Platform Setup Configuration
// ----------------------------------------

// NOTE(yoshi): Required to pass code to function service. Ignore typescript types here.
// @ts-ignore 
globalThis.main = selectUser;

// ----------------------------------------
// type settings for function input
// ----------------------------------------

const selectUserSchema = z.object({
    dbInfo: DbInfoSchema,
});
type SelectUserInput = z.infer<typeof selectUserSchema>;
const db = getDB<DB>();

// ----------------------------------------
// Function Implementation
// ----------------------------------------

export async function selectUser(args: any) {
    const input = selectUserSchema.safeParse(args);
    if (!input.success) {
        throw new Error(`Invalid input: ${JSON.stringify(input.error)}`);
    }
    const result = await _selectUser(input.data);
    return result;
};

async function _selectUser(input: SelectUserInput) {
    const client = getDbClient(input.dbInfo);

    await client.connect();
    const query = db
        .selectFrom('User')
        .select(['id', 'name', 'email'])
        .compile();
    const result = (await client.queryObject(query.sql)).rows as QueryReturnType<typeof query>[];

    await client.end();

    return {
        users: result
    };
}
