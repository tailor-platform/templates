import { logger } from "@tailor-platform/function-logger";
import { formatError } from "./utils";

/**
 * Example: File Download
 *
 * This example demonstrates how to download a file and access its content and metadata.
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

  logger.info("=== File Download ===");

  try {
    // Use TailorDB file API to download file
    // If download fails, it will throw TailorDBFileError
    const downloadResponse = await tailordb.file.download(
      "galaxy",
      "Starship",
      "blueprint",
      starshipId
    );

    // Success case - API guarantees metadata is present
    logger.info(`Downloaded file: ${downloadResponse.metadata.fileSize} bytes`);
    logger.info(`Content type: ${downloadResponse.metadata.contentType}`);

    // Convert Uint8Array back to string for text files
    const downloadedText = new TextDecoder().decode(downloadResponse.data);
    logger.info(`Content preview: ${downloadedText}`);

    return {
      message: "File download completed successfully",
      fileSize: downloadResponse.metadata.fileSize,
      contentType: downloadResponse.metadata.contentType,
      contentPreview: downloadedText,
    };
  } catch (error) {
    logger.error("Error in download:", error);

    return {
      message: "File download failed",
      error: formatError(error),
    };
  }
};