import { gql, request } from "graphql-request";

globalThis.main = async function (args) {
  const document = gql`
    query ExampleQuery($pokemon: String!) {
      getFuzzyPokemon(pokemon: $pokemon) {
        species
      }
    }
  `;

  const variables = {
    pokemon: args.pokemon, // e.g., "rayquaza"
  };
  let res = await request(
    "https://graphqlpokemon.favware.tech/v8",
    document,
    variables,
  );

  return { species: res.getFuzzyPokemon[0].species };
};
