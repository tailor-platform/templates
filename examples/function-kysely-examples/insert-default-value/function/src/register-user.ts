import { Kysely, sql } from "kysely";
import { TailordbDialect } from "@tailor-platform/function-kysely-tailordb";
import { DB } from "../types/tailordb";

type Input = {
  name?: string;
};

export default async function main(input: Input) {
  const client = new tailordb.Client({
    namespace: "demo",
  });
  const db = new Kysely<DB>({
    dialect: new TailordbDialect(client),
  });

  if (!input.name) {
    await db.insertInto("User").defaultValues().executeTakeFirstOrThrow();
  } else {
    await db
      .insertInto("User")
      .values({
        name: input.name,
        createdAt: sql`DEFAULT`,
      })
      .executeTakeFirstOrThrow();
  }
}
