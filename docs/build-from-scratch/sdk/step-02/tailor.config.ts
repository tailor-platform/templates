import { defineAuth, defineConfig } from "@tailor-platform/sdk";
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
});