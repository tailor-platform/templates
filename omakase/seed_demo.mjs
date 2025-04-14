import pkg from "@apollo/client";
import { $$ } from "@tailor-platform/dev-cli/script";
import { promises as fs, readFileSync } from 'fs';
import path from "path";
import { exec } from "child_process";
import util from "util";
import minimist from "minimist";
import prompts from "prompts";
import cliProgress from "cli-progress";

const { ApolloClient, HttpLink, gql, InMemoryCache } = pkg;

const execAsync = util.promisify(exec);
const args = minimist(process.argv.slice(2));
let { ignoreExisting, generateTestDataArg, skipPrompts } = args;
ignoreExisting = !!args["ignore-existing"];
generateTestDataArg = args["generate-test-data"] !== undefined ? (args["generate-test-data"] || "tests/data") : undefined;
skipPrompts = !!args["skip-prompts"];

const uuidMap = {};

let selectedApp, selectedWorkspace;

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
				console.error(
					"\x1b[31m%s\x1b[0m",
					"Token is expired. running login command..."
				);
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

async function generateMachineUserToken() {
  try {
    const tokenResult = await $$({
      stdio: "pipe",
    })`tailorctl workspace machineuser token -a ${selectedApp.name} -m admin-machine-user -f json`;
    const token = JSON.parse(tokenResult.stdout);
    // Directly access the parsed result assuming $$ already parses the JSON output
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


async function mutatePipeline(jsonPath, token) {
  const client = new ApolloClient({
    link: new HttpLink({
      uri: `${selectedApp.url}/query`,
      headers: {
        Authorization: `Bearer ${token}`,
      },
    }),
    cache: new InMemoryCache(),
  });

  // Create a new instance of ApolloClient with the token and possibly custom URI included in the headers
  const jsonData = readFileSync(jsonPath);

  let data;
  try {
    data = JSON.parse(jsonData);
  } catch (e) {
    console.log("Error parsing JSON data");
    throw Error(e);
  }

  const progressBars = {};
  for (const key in data) {
    let gqlQuery = `
      mutation ($input: ${key}CreateInput!) {
        create${key} (input: $input) {
          id
        }
      }
    `
    if ("query" in data[key]) {
      gqlQuery = data[key].query;
    }
    const query = gql(gqlQuery);

    progressBars[key] = new cliProgress.SingleBar(
      {
        format: `| Seeding ${key.padEnd(
          20
        )} | [{bar}] {percentage}% | ETA: {eta}s | {value}/{total}`,
      },
      cliProgress.Presets.shades_classic
    );

    progressBars[key].start(data[key].items.length, 0);
    for (const item of data[key].items) {
      await client
        .mutate({
          mutation: query,
          variables: {
            input: item,
          },
        })
        .catch((e) => {
          if (e.message.includes("already exists")) {
            if (ignoreExisting) {
              return;
            }
            console.error(
              "\x1b[31m%s\x1b[0m",
              "\nKey already exists. Use --ignore-existing flag to ignore this error."
            );
            process.exit(1);
          }
          throw e;
        });
      await new Promise((r) => setTimeout(r, 100));
      progressBars[key].increment();
    }
    progressBars[key].stop();
  }
}

async function findCueFiles(dir) {
	const entries = await fs.readdir(dir, { withFileTypes: true });
	const cueFiles = [];

	for (const entry of entries.sort((a, b) => a.name.localeCompare(b.name))) {
		const fullPath = path.join(dir, entry.name);

		// Check if the path includes a 'utils' directory segment
		if (fullPath.includes(`${path.sep}utils${path.sep}`) || fullPath.endsWith(`${path.sep}utils`)) {
			continue; // Skip this directory and its contents
		}

		if (entry.isDirectory()) {
			cueFiles.push(...await findCueFiles(fullPath));
		} else if (entry.name.endsWith('.cue')) {
			cueFiles.push(fullPath);
		}
	}

	return cueFiles;
  }


async function generateTestData(seedFilePath, outputPath) {
	// Load the existing seed data from the JSON file
	const seedDataRaw = await fs.readFile(seedFilePath, 'utf8');
	const seedData = JSON.parse(seedDataRaw);

	// Function to recursively replace UUIDs with references
	function replaceUUIDs(value) {
		if (typeof value === "string" && uuidMap[value]) {
			return { "UUID": uuidMap[value] };
		} else if (Array.isArray(value)) {
			return value.map(item => replaceUUIDs(item));
		} else if (typeof value === "object" && value !== null) {
			const newValue = {};
			for (const key in value) {
				newValue[key] = replaceUUIDs(value[key]);
			}
			return newValue;
		}
		return value;
	}

	// Convert the array of items to an object and replace UUIDs with new reference paths
	const testData = {};

	for (const entityType in seedData) {
		const entityList = seedData[entityType].items;
		testData[entityType] = {};

		entityList.forEach((entity, index) => {
			const newEntity = {};

			for (const key in entity) {
				newEntity[key] = replaceUUIDs(entity[key]);
			}

			// Assign a new key for the entity in the test data, increment index by 1 for naming
			const newKey = `${entityType.toLowerCase()}${index + 1}`;
			testData[entityType][newKey] = newEntity;

			// Update UUID map with new key
			uuidMap[entity.id] = `${entityType}.${newKey}`;

			// Remove the 'id' field to avoid storing UUIDs in the test data
			delete newEntity.id;
		});
	}

	// Use the provided output path if specified, otherwise default to the same directory as seed file
	const outputFilePath = outputPath || path.join(path.dirname(seedFilePath), `${path.basename(seedFilePath, '.json')}_testData.json`);

	// Write the testData to a new JSON file
	await fs.writeFile(outputFilePath, JSON.stringify(testData, null, 2));

	console.log(`Test data generated and saved to ${outputFilePath}`);
}

async function seed() {
	const token = await generateMachineUserToken();
	const seedDir = path.join('.', 'demo');

	const cueFiles = await findCueFiles(seedDir);
    console.log("Using graphql endpoint", `${selectedApp.url}/query`);
	for (const file of cueFiles) {
        // Assuming `file` is an object and the path is stored in `filePath`
        const filePath = file.filePath || file; // Adjust according to your `findCueFiles` return structure
		const jsonPath = `./tmp/${path.basename(filePath, '.cue')}_seed.json`;
		try {
			await execAsync(`cue eval ${filePath} --out json > ${jsonPath}`, { shell: true });
			if (generateTestDataArg) {
				console.log(`Generating test data in folder: ${generateTestDataArg}`);
				const testDataPath = path.join(generateTestDataArg, `${path.basename(filePath, '.cue')}.json`);
				await generateTestData(jsonPath, testDataPath);
			} else {
				await mutatePipeline(jsonPath, token);
			}
		} catch (error) {
			console.error("\x1b[31m%s\x1b[0m", `Error processing ${filePath}: ${error.message}`);
			if (!error.message.includes("no CUE files")) throw error;
		}
    }
	console.log("\x1b[32m%s\x1b[0m", "All seed files processed successfully.");
}

async function main() {
	const tmpDir = path.join('.', 'tmp');

	// Remove the tmp directory if it exists
	try {
		await fs.rm(tmpDir, { recursive: true, force: true });
	} catch (error) {
		console.error(`Failed to remove directory ${tmpDir}:`, error);
	}

	// Create the tmp directory
	try {
		await fs.mkdir(tmpDir, { recursive: true });
	} catch (error) {
		console.error(`Failed to create directory ${tmpDir}:`, error);
	}

	await configureEnvironment();
	await seed();
}

main().catch(error => {
    console.error("An error occurred:", error);
    process.exit(1);
});
