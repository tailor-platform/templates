import { logger } from "@tailor-platform/function-logger";

/**
 * Example: Setup - Create Test Starship Record
 *
 * This example demonstrates how to create a test Starship record
 * that will be used for file operations in subsequent examples.
 */
export default async () => {
  logger.info("=== Setup: Creating Test Starship Record ===");

  try {
    const client = new tailordb.Client({ namespace: "galaxy" });
    await client.connect();

    // Create a test starship record
    const createResult = await client.queryObject<{ id: string; name: string }>(
      `INSERT INTO "Starship" (name, "serialNumber", status, "isArmed", crew, capacity, length)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING id, name`,
      [
        "File API Test X-wing",
        "12345678-1234-5678-9abc-123456789abc",
        "ACTIVE",
        true,
        1,
        1,
        12.5
      ]
    );

    if (createResult.rows.length === 0) {
      throw new Error("Failed to create starship record");
    }

    const starship = createResult.rows[0];
    logger.info(`Created test starship: ${starship.name} (ID: ${starship.id})`);

    await client.end();

    return {
      message: "Setup completed successfully",
      starshipId: starship.id,
      name: starship.name,
    };
  } catch (error) {
    logger.error("Setup error:", error);
    logger.error("Make sure the star-wars application is deployed with the correct Starship schema");

    return {
      message: "Setup failed",
      error: error instanceof Error ? error.message : String(error),
    };
  }
};