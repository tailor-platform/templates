import {
    CompiledQuery,
    DummyDriver,
    Kysely,
    PostgresAdapter,
    PostgresIntrospector,
    PostgresQueryCompiler
} from "kysely";
import { z } from "zod";
import { Client, Transaction } from "./client";

declare global {
	  // @ts-ignore tailordb will be available in the function service
    const tailordb: {
        Client: Client
    }
}

export const getDB = <T>() => {
    return new Kysely<T>({
        dialect: {
            createAdapter() {
                return new PostgresAdapter();
            },
            createDriver() {
                // we cannot query in deno runtime
                return new DummyDriver();
            },
            createIntrospector(db: Kysely<unknown>) {
                return new PostgresIntrospector(db);
            },
            createQueryCompiler() {
                return new PostgresQueryCompiler();
            },
        },
    });
}

export const DbInfoSchema = z.object({
    namespace: z.string(),
});

type DbInfo = z.infer<typeof DbInfoSchema>;

// Helper type to extract the type from CompiledQuery<Simplify<O>>
export type QueryReturnType<T> = T extends CompiledQuery<infer U> ? U : never;


export function getDbClient(dbInfo: DbInfo) {
    return new tailordb.Client({
        namespace: dbInfo.namespace
    });
}

export type { Client, Transaction };