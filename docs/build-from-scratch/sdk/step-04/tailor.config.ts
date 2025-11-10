import { defineAuth, defineConfig, defineGenerators, } from "@tailor-platform/tailor-sdk";
import { user } from "./src/db/user";

if (!process.env.WORKSPACE_ID) {
  throw new Error("WORKSPACE_ID environment variable is not set");
}

export default defineConfig({
  workspaceId: process.env.WORKSPACE_ID,
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
  pipeline: { "main-pipeline": { files: [`./src/pipeline/*.ts`] } },
  executor: { files: ["./src/executor/*.ts"] },
});

export const generators = defineGenerators(
  ["@tailor/kysely-type", { distPath: `./src/generated/tailordb.ts` },]
);