# function-kysely-codegen

A sample for executing `kysely-codegen` in the Function service.

## Usage

```sh
pnpm install
pnpm run build
tailorctl workspace function test-run \
    -a star-wars \
    -g '{"namespace": "galaxy"}' \
    -m r2d2 -s 'dist/index.js' | grep -o '{.*}' | jq -r '.data' > db.d.ts
```