import { build } from "esbuild";
import { globSync } from "node:fs";

const entryPoints = globSync("src/**/*.ts");

build({
  bundle: true,
  entryPoints,
  format: "esm",
  outdir: "dist",
  minify: true,
});
