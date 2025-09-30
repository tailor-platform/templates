import { logger } from "@tailor-platform/function-logger";
import { formatError } from "./utils";

/**
 * Example: File Upload
 *
 * This example demonstrates how to upload files of different types:
 * - Text files (blueprint)
 * - Binary files (PNG image)
 *
 * Note: You need to provide a valid starshipId from the setup step.
 */
export default async (args: { starshipId: string }) => {
  const { starshipId } = args;

  if (!starshipId) {
    return {
      message: "starshipId is required",
      error: "Please run setup.ts first to create a starship record",
    };
  }

  const results: Record<string, any> = {};

  // === Upload Text File (Blueprint) ===
  logger.info("=== Uploading Blueprint (Text File) ===");

  try {
    const blueprintContent = "X-wing Fighter Blueprint\nEngine Type: Ion Drive\nWeapons: 4x Laser Cannons\nShields: Deflector Shield";

    // Use TailorDB file API to upload file
    // API throws TailorDBFileError on failure
    const uploadResponse = await tailordb.file.upload(
      "galaxy",
      "Starship",
      "blueprint",
      starshipId,
      blueprintContent,
      { contentType: "text/plain" }
    );

    logger.info(`Uploaded blueprint: ${uploadResponse.metadata.fileSize} bytes`);
    logger.info(`SHA256: ${uploadResponse.metadata.sha256sum}`);

    results.blueprintUpload = {
      fileSize: uploadResponse.metadata.fileSize,
      sha256sum: uploadResponse.metadata.sha256sum,
      contentType: "text/plain",
    };
  } catch (error) {
    logger.error("Error in blueprint upload:", error);
    results.blueprintUploadError = formatError(error);
  }

  // === Upload Binary File (Thumbnail Image) ===
  logger.info("=== Uploading Thumbnail (Image File) ===");

  try {
    // Simulate a simple PNG image (PNG signature + minimal data)
    const pngData = new Uint8Array([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
      0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR chunk header
      0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, // 1x1 pixel
      0x08, 0x02, 0x00, 0x00, 0x00, 0x90, 0x77, 0x53, // bit depth, color type, etc.
      0xDE, 0x00, 0x00, 0x00, 0x0C, 0x49, 0x44, 0x41, // IDAT chunk
      0x54, 0x08, 0x99, 0x01, 0x01, 0x00, 0x00, 0x00, // minimal image data
      0xFF, 0xFF, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01  // end of minimal data
    ]);

    // Upload binary image data
    const imageUploadResponse = await tailordb.file.upload(
      "galaxy",
      "Starship",
      "thumbnail",
      starshipId,
      pngData,
      { contentType: "image/png" }
    );

    logger.info(`Uploaded thumbnail: ${imageUploadResponse.metadata.fileSize} bytes`);

    results.thumbnailUpload = {
      fileSize: imageUploadResponse.metadata.fileSize,
      sha256sum: imageUploadResponse.metadata.sha256sum,
      contentType: "image/png",
    };
  } catch (error) {
    logger.error("Error in thumbnail upload:", error);
    results.thumbnailUploadError = formatError(error);
  }

  return {
    message: "File upload examples completed",
    results,
  };
};