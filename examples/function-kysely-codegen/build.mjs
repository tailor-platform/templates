import { build } from "esbuild";
import { createRequire } from "node:module";
import path from "node:path";
import { nodeless } from "unenv";

const require = createRequire(import.meta.url);

// When importing the Node API (e.g., `import path from "node:path"`),
// the unenv package should be bundled to run even in the Function service.
// Functions that are difficult to execute in the Function service (e.g., `fs.writeFile`)
// will be bundled as mocks and will throw a "not implemented" error at runtime.
const unenvAlias = {
  name: "unenv-alias",
  setup(build) {
    const alias = nodeless.alias;
    const re = new RegExp(`^(${Object.keys(alias).join("|")})$`);

    build.onResolve({ filter: re }, (args) => {
      const resolved = require.resolve(alias[args.path]);
      // Since require.resolve() always resolves to cjs,
      // it needs to be converted to mjs when this callback is invoked via import.
      const path = args.kind === "require-call" ? resolved : resolved.replace(/\.cjs$/, ".mjs");
      return { path };
    });
  },
};

// Inject the unenv package to emulate the behavior of global variables (e.g., process)
// that do not exist within the Function service.
const unenvInject = {
  name: "unenv-inject",
  setup(build) {
    const inject = nodeless.inject;
    const re = /unenv-inject-([^.]+)\.js$/;
    const prefix = path.join(import.meta.dirname, "unenv-inject-");

    build.initialOptions.inject = [
      ...(build.initialOptions.inject ?? []),
      ...Object.keys(inject).map((globalName) => `${prefix}${globalName}.js`),
    ];

    build.onResolve({ filter: re }, ({ path }) => ({ path }));

    build.onLoad({ filter: re }, ({ path }) => {
      const globalName = path.match(re)[1];
      return {
        contents: getInjectContent(globalName, inject[globalName]),
      };
    });
  },
};

const getInjectContent = (globalName, globalInject) => {
  if (typeof globalInject === "string") {
    return `import globalVar from "${globalInject}"; globalThis.${globalName} = globalVar;`;
  }
  const [moduleSpecifier, exportName] = globalInject;
  return `import { ${exportName} } from "${moduleSpecifier}"; globalThis.${globalName} = ${exportName};`;
};

// Since shelljs, which git-diff depends on, uses dynamic require (e.g., `require('./main' + path)`),
// bundling it is challenging. However, since git-diff is not invoked in this use case, it will be mocked instead.
const mockGitDiff = {
  name: "mock-git-diff",
  setup(build) {
    build.onResolve({ filter: /^git-diff$/ }, (args) => {
      return { path: args.path, namespace: "git-diff" };
    });
    build.onLoad({ filter: /.*/, namespace: "git-diff" }, () => {
      return { contents: "export default null" };
    });
  },
};

build({
  bundle: true,
  entryPoints: ["src/index.ts"],
  format: "esm",
  outfile: "dist/index.js",
  define: {
    "global": "globalThis",
  },
  minify: true,
  plugins: [unenvAlias, unenvInject, mockGitDiff],
  // Since drivers like pg are not needed, they will be left as-is without bundling.
  external: ["pg", "mysql2", "@libsql/kysely-libsql", "better-sqlite3", "tarn", "tedious", "@tediousjs/connection-string"]
});
