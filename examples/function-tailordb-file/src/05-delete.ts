import { logger } from "@tailor-platform/function-logger";
import { formatError } from "./utils";

/**
 * Example: File Deletion
 *
 * This example demonstrates how to delete a file.
 *
 * Note: You need to provide a valid starshipId with an uploaded file.
 */
export default async (args: { starshipId: string }) => {
  const { starshipId } = args;

  if (!starshipId) {
    return {
      message: "starshipId is required",
      error: "Please run setup.ts and 01-upload.ts first",
    };
  }

  logger.info("=== File Deletion ===");

  try {
    // Use TailorDB file API to delete file
    // If deletion fails, it will throw a TailorDBFileError
    await tailordb.file.delete(
      "galaxy",
      "Starship",
      "thumbnail",
      starshipId
    );

    logger.info("Thumbnail file deleted successfully");

    return {
      message: "File deletion completed successfully",
      success: true,
      deletedField: "thumbnail",
    };
  } catch (error) {
    logger.error("Error in file deletion:", error);

    return {
      message: "File deletion failed",
      error: formatError(error),
    };
  }
};