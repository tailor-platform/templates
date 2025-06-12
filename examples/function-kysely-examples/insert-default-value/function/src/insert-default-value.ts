import { Kysely, sql } from "kysely";
import { TailordbDialect } from "@tailor-platform/function-kysely-tailordb";
import { DB } from "../types/tailordb";

export default async function main() {
  const client = new tailordb.Client({
    namespace: "demo",
  });
  const db = new Kysely<DB>({
    dialect: new TailordbDialect(client),
  });

  const defaultRecord = await db
    .insertInto("User")
    .defaultValues()
    .returningAll()
    .executeTakeFirstOrThrow();
  console.log("Default Record:", defaultRecord);

  const defaultRecordWithName = await db
    .insertInto("User")
    .values({
      name: "Alice",
      createdAt: sql`DEFAULT`,
    })
    .returningAll()
    .executeTakeFirstOrThrow();
  console.log("Default Record with Name:", defaultRecordWithName);
}
