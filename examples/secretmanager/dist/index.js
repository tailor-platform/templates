// src/index.ts
var index_default = async () => {
  console.log("start");
  let secrets = await tailor.secretmanager.getSecrets("default", ["fakeoidc-client-secret", "scim-secret"]);
  let jsonSecrets = JSON.stringify(secrets);
  console.log(`getSecrets: ${jsonSecrets}`);
  let secret = await tailor.secretmanager.getSecret("default", "scim-secret");
  console.log(`getSecret with scim-secret: ${secret}`);
  return {
    secrets: jsonSecrets
  };
};
export {
  index_default as default
};
