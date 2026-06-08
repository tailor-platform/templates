import { defineConfig } from "@tailor-platform/sdk";

export default defineConfig({
  name: "project-management",
  db: { "main-db": { files: [`./src/db/*.ts`] } }
});