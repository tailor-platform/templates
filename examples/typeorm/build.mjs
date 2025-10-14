import { build } from "esbuild";

build({
  bundle: true,
  entryPoints: ["src/index.ts"],
  format: "esm",
  outfile: "dist/index.js",
  platform: "browser",
  mainFields: ["browser", "module", "main"],
  conditions: ["browser", "import", "default"],
  define: {
    global: "globalThis",
  },
  minify: true,
});
