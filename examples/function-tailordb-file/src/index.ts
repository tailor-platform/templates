import { logger } from "@tailor-platform/function-logger";
import setup from "./setup";
import upload from "./01-upload";
import metadata from "./02-metadata";
import download from "./03-download";
import streaming from "./04-streaming";
import deleteFile from "./05-delete";

/**
 * Comprehensive TailorDB File API Examples
 *
 * This example demonstrates all File API operations in a single workflow:
 * 1. Setup: Create a test Starship record
 * 2. Upload: Upload text and binary files
 * 3. Metadata: Retrieve file metadata
 * 4. Download: Download files and access content
 * 5. Streaming: Download large files efficiently
 * 6. Delete: Remove files
 *
 * For individual examples, see the separate files: setup.ts, 01-upload.ts, etc.
 */
export default async () => {
  logger.info("Starting TailorDB File API examples");

  // 1. Setup
  const setupResult = await setup();
  if ("error" in setupResult || !setupResult.starshipId) {
    return setupResult;
  }
  const starshipId = setupResult.starshipId;

  // 2. Upload
  const uploadResult = await upload({ starshipId });

  // 3. Metadata
  const metadataResult = await metadata({ starshipId });

  // 4. Download
  const downloadResult = await download({ starshipId });

  // 5. Streaming
  const streamingResult = await streaming({ starshipId });

  // 6. Delete
  const deleteResult = await deleteFile({ starshipId });

  logger.info("\n=== TailorDB File API Examples Completed ===");

  return {
    message: "TailorDB File API examples executed successfully",
    results: {
      setup: setupResult,
      upload: uploadResult,
      metadata: metadataResult,
      download: downloadResult,
      streaming: streamingResult,
      deletion: deleteResult
    }
  };
};