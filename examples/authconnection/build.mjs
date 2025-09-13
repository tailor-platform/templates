import { build } from "esbuild";

build({
  bundle: true,
  entryPoints: ["src/index.ts"],
  format: "esm",
  outfile: "dist/index.js",
  define: {
    "global": "globalThis",
  },
  minify: false
});
