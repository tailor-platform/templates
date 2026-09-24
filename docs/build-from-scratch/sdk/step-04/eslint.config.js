import js from "@eslint/js";
import { defineConfig } from "eslint/config";
import tseslint from "typescript-eslint";

export default defineConfig(
  { ignores: ["src/generated/**", "tailor.d.ts", ".tailor/**"] },
  js.configs.recommended,
  tseslint.configs.recommended,
);
