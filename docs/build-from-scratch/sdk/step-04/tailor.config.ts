import { defineAuth, defineConfig, defineGenerators, } from "@tailor-platform/sdk";
import { user } from "./src/db/user";

export default defineConfig({
  name: "project-management",
  db: { "main-db": { files: [`./src/db/*.ts`] } },
  auth: defineAuth("main-auth", {
    userProfile: {
      type: user,
      usernameField: "email",
      attributes: {
        role: true,
      },
    },
    machineUsers: {
      manager: {
        attributes: { role: "MANAGER" },
      },
      staff: {
        attributes: { role: "STAFF" },
      },
      admin: {
        attributes: { role: "ADMIN" },
      },
    },
  }),
  resolver: { "main-resolver": { files: [`./src/resolver/*.ts`] } },
  executor: { files: ["./src/executor/*.ts"] },
});

export const generators = defineGenerators(
  ["@tailor-platform/kysely-type", { distPath: `./src/generated/tailordb.ts` },]
);