tailorctl workspace function test-run \
  -a 'demo' \
  -g '{"namespace": "demo"}' \
  -m 'admin' \
  -s './scripts/kysely-codegen.js' | grep -o '{.*}' | jq -r '.data' > ./types/tailordb.d.ts