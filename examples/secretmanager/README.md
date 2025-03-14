# function-secretmanager

A sample for executing `secretmanager` in the Function service.

## Usage

```sh
pnpm install
pnpm run build
tailorctl workspace function test-run \
    -a star-wars \
    -m r2d2 -s 'dist/index.js' --tail
```