# function-pdfme

A sample for executing `pdfme` in the Function service.

## Usage

```sh
pnpm install
pnpm run build
tailorctl workspace function test-run -a star-wars -m r2d2 -s 'dist/index.js' \
  | grep -o '{.*}' \
  | jq -r '.data' \
  | base64 -d > out.pdf
```
