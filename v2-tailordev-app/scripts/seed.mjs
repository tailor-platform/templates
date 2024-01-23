import { $$, cue, tailorctl } from "@tailor-platform/dev-cli/script";

const importSeed = async (args) => {
	await $$`${tailorctl} alpha workspace tailordb import --namespace galaxy ${args}`
}

await $$`rm -rf ./tmp`
await $$`mkdir -p ./tmp`
await $$`${cue} eval ./manifest/seed/*.cue -e RolesArray --out json > ./tmp/roles.json`
await $$`${cue} eval ./manifest/seed/*.cue -e AffiliationsArray --out json > ./tmp/affiliations.json`
await $$`${cue} eval ./manifest/seed/*.cue -e SpeciesArray --out json > ./tmp/species.json`
await $$`${cue} eval ./manifest/seed/*.cue -e Characters --out json > ./tmp/characters.json`
await importSeed("--type Role --json ./tmp/roles.json")
await importSeed("--type Affiliation --json ./tmp/affiliations.json")
await importSeed("--type Species --json ./tmp/species.json")
await importSeed("--type Character --json ./tmp/characters.json")
