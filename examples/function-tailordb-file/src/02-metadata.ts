import { logger } from "@tailor-platform/function-logger";
import { formatError } from "./utils";

/**
 * Example: File Metadata
 *
 * This example demonstrates how to retrieve file metadata without downloading the entire file.
 * This is useful when you only need information about the file (size, content type, checksum, etc.)
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

  logger.info("=== Get File Metadata ===");

  try {
    // Use TailorDB file API to get file metadata
    // API returns metadata object directly, throws TailorDBFileError on failure
    const metadata = await tailordb.file.getMetadata(
      "galaxy",
      "Starship",
      "blueprint",
      starshipId
    );

    // Success case - API guarantees metadata is present and valid
    logger.info("File metadata:");
    logger.info(`  Content Type: ${metadata.contentType}`);
    logger.info(`  File Size: ${metadata.fileSize} bytes`);
    logger.info(`  SHA256: ${metadata.sha256sum}`);
    if (metadata.lastUploadedAt) {
      logger.info(`  Last Uploaded: ${metadata.lastUploadedAt}`);
    }

    return {
      message: "File metadata retrieved successfully",
      contentType: metadata.contentType,
      fileSize: metadata.fileSize,
      sha256sum: metadata.sha256sum,
      lastUploadedAt: metadata.lastUploadedAt,
    };
  } catch (error) {
    logger.error("Error getting metadata:", error);

    return {
      message: "Failed to get file metadata",
      error: formatError(error),
    };
  }
};