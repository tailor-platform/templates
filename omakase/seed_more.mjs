#!/usr/bin/env node

import pkg from "@apollo/client";
import { $$ } from "@tailor-platform/dev-cli/script";
import minimist from "minimist";
import prompts from "prompts";
import { print } from "graphql";

const { ApolloClient, HttpLink, gql, InMemoryCache } = pkg;

const args = minimist(process.argv.slice(2));
let { ignoreExisting, generateTestDataArg, skipPrompts } = args;
ignoreExisting = !!args["ignore-existing"];
generateTestDataArg =
  args["generate-test-data"] !== undefined
    ? args["generate-test-data"] || "tests/data"
    : undefined;
skipPrompts = !!args["skip-prompts"];

let selectedApp, selectedWorkspace;

/**
 * Configure your environment by selecting or confirming the workspace/app.
 */
async function configureEnvironment() {
  let workspace;
  do {
    let workspaceJsonString;
    try {
      workspaceJsonString = await $$({
        stdio: "pipe",
      })`tailorctl workspace describe -f json`;
    } catch (error) {
      if (error.message.includes("token is expired")) {
        console.error("\x1b[31m%s\x1b[0m", "Token is expired. running login command...");
        await $$`tailorctl auth login`;
        await $$`tailorctl config switch default`;
        continue;
      }
      if (error.message.includes("workspace_id must be specified")) {
        await selectWorkspace();
        continue;
      }
      throw error;
    }
    try {
      workspace = JSON.parse(workspaceJsonString.stdout);
    } catch (error) {
      console.error("Error parsing workspace");
      process.exit(1);
    }
  } while (!workspace);

  if (workspace.name) {
    if (!skipPrompts) {
      const continuePrompt = await prompts({
        type: "confirm",
        name: "value",
        message: `Do you want to use the workspace ${workspace.name}?`,
        initial: true,
      });
      if (!continuePrompt.value) {
        await selectWorkspace();
      } else {
        selectedWorkspace = workspace;
      }
    } else {
      selectedWorkspace = workspace; // Auto-select the first workspace
    }
  }
  const appsJsonString = await $$({
    stdio: "pipe",
  })`tailorctl workspace app list -f json`;
  const apps = JSON.parse(appsJsonString.stdout);

  // If skipPrompts is true, auto-select the first app
  if (skipPrompts) {
    selectedApp = apps[0];
  } else {
    // prompt user to select an app
    const result = await prompts({
      type: "select",
      name: "value",
      message: "Select an app",
      choices: apps.map((app) => ({
        title: app.name,
        value: app,
      })),
    });
    selectedApp = result.value;
  }
}

/**
 * Prompt user to select a workspace if needed.
 */
async function selectWorkspace() {
  const workspacesJsonString = await $$({
    stdio: "pipe",
  })`tailorctl workspace list -f json`;
  const workspaces = JSON.parse(workspacesJsonString.stdout);
  // If skipPrompts is true, auto-select the first workspace
  if (skipPrompts) {
    selectedWorkspace = workspaces[0];
  } else {
    // prompt user to select a workspace
    const result = await prompts({
      type: "select",
      name: "value",
      message: "Select a workspace",
      choices: workspaces.map((workspace) => ({
        title: workspace.name,
        value: workspace,
      })),
    });
    selectedWorkspace = result.value;
  }

  if (!selectedWorkspace) {
    console.error("\x1b[31m%s\x1b[0m", "No workspace selected");
    process.exit(1);
  }
  await $$`tailorctl config set workspaceId ${selectedWorkspace.id}`;
}

/**
 * Generate a machine-user token for the selected app.
 */
async function generateMachineUserToken() {
  try {
    const tokenResult = await $$({
      stdio: "pipe",
    })`tailorctl workspace machineuser token -a ${selectedApp.name} -m admin-machine-user -f json`;
    const token = JSON.parse(tokenResult.stdout);

    if (Array.isArray(token) && token.length > 0 && token[0].access_token) {
      return token[0].access_token; // Extract the access token value
    } else {
      throw new Error("Token not found in the response.");
    }
  } catch (error) {
    console.error("Error retrieving token:", error);
    throw new Error("Failed to retrieve token.");
  }
}

/**
 * Helper to create an Apollo Client with the given token.
 */
function createApolloClient(token) {
  return new ApolloClient({
    link: new HttpLink({
      uri: `${selectedApp.url}/query`, // GraphQL endpoint
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }),
    cache: new InMemoryCache(),
  });
}

// GQL for creating a manufacturing order and related work orders.
const CREATE_MANUFACTURING_ORDER = gql`
  mutation ($input: createManufacturingInput!) {
    createManufacturingOrderAndWorkOrders(input: $input) {
      manufacturingOrderId
    }
  }
`;

// GQL to plan a manufacturing order.
const PLAN_MANUFACTURING_ORDER = gql`
  mutation ($input: PlanManufacturingOrderInput!) {
    planManufacturingOrder(input: $input) {
      success
    }
  }
`;

// GQL to update the manufacturing order.
const UPDATE_MANUFACTURING_ORDER = gql`
mutation ($id: ID!, $input: ManufacturingOrderUpdateInput!) {
  updateManufacturingOrder(id: $id, input: $input) {
    id
    status
  }
}
`;

/**
 * Create 10 manufacturing orders and plan each one.
 */
async function createAndPlanManufacturingOrders(token) {
  const client = createApolloClient(token);

  for (let i = 1; i <= 10; i++) {
    const moName = `Order No${i} Ace Iconic Performance Hat`;

    // 1) Create the MO
    const createResponse = await client.mutate({
      mutation: CREATE_MANUFACTURING_ORDER,
      variables: {
        input: {
          name: moName,
          bomId: "5b01aba3-4064-53b9-a229-b2b718d65531", // Update this if needed
          quantity: 1,
        },
      },
    });

    const manufacturingOrderId =
      createResponse.data.createManufacturingOrderAndWorkOrders.manufacturingOrderId;

    console.log(`Created '${moName}' with ID: ${manufacturingOrderId}`);

    // 2) Plan the MO
    const planResponse = await client.mutate({
      mutation: PLAN_MANUFACTURING_ORDER,
      variables: {
        input: {
          manufacturingOrderId,
          scheduleDateTime: "2025-01-01T00:00:00.000Z", // Update date/time as needed
        },
      },
    });

    // 3) Update the MO status for the first 5 MOs
    // (Newly added code below)
    if (i <= 5) {
      const updateResponse = await client.mutate({
        mutation: UPDATE_MANUFACTURING_ORDER,
        variables: {
          id: manufacturingOrderId,
          input: {
            status: "In_Progress",
          },
        },
      });
      
      console.log(
        `Updated status of '${moName}' to '${updateResponse.data.updateManufacturingOrder.status}' ` +
        `(ID: ${manufacturingOrderId}).`
      );
    }

    if (planResponse.data.planManufacturingOrder.success) {
      console.log(
        `Successfully planned '${moName}' (ID: ${manufacturingOrderId}).\n`
      );
    } else {
      console.warn(
        `Failed to plan '${moName}' (ID: ${manufacturingOrderId}).\n`
      );
    }
  }
}

/**
 * Orchestrates the .cue seeding and then the manufacturing creation & planning.
 */
async function seed() {
  // 1) Generate machine-user token
  const token = await generateMachineUserToken();

  // 4) Now create and plan your 10 manufacturing orders
  await createAndPlanManufacturingOrders(token);
}

/**
 * Main entry point.
 */
async function main() {

  // Configure environment (workspace, app, etc.)
  await configureEnvironment();

  // Run the seeding process (then create/plan MOs)
  await seed();
}

// Run the script
main().catch((error) => {
  console.error("An error occurred:", error);
  process.exit(1);
});
