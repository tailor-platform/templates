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

  await db
    .insertInto("Product")
    .values([
      {
        name: "Running Shoes",
        description: "Lightweight running shoes with breathable material.",
      },
      {
        name: "Trail Shoes",
        description: "Outdoor shoes with strong grip for rough terrain.",
      },
      {
        name: "Casual Sneakers",
        description: "Simple sneakers suitable for everyday use.",
      },
    ])
    .onConflict((oc) => oc.column("name").doNothing())
    .execute();

  const shoesForRunning = await db
    .selectFrom("Product")
    .selectAll()
    .orderBy(
      ({ fn, val }) =>
        fn("vector_similarity", [
          "description",
          val("Shoes that are good for running"),
        ]),
      "desc"
    )
    .limit(1)
    .execute();
  console.log("Shoes for running:", shoesForRunning[0]);

  const shoesForEverydayUse = await db
    .selectFrom("Product")
    .selectAll()
    .orderBy(
      ({ fn, val }) =>
        fn("vector_similarity", [
          "description",
          val("Shoes that are good for everyday use"),
        ]),
      "desc"
    )
    .limit(1)
    .execute();
  console.log("Shoes for everyday use:", shoesForEverydayUse[0]);
}
