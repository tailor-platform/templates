import { logger } from "@tailor-platform/function-logger";
import { formatError } from "./utils";

/**
 * Example: Streaming Download for Large Files
 *
 * This example demonstrates how to efficiently download large files using streaming.
 * Streaming is useful when dealing with files that are too large to fit in memory at once.
 *
 * Note: You need to provide a valid starshipId. This example will upload a large file first.
 */
export default async (args: { starshipId: string }) => {
  const { starshipId } = args;

  if (!starshipId) {
    return {
      message: "starshipId is required",
      error: "Please run setup.ts first",
    };
  }

  logger.info("=== Streaming Download Demo ===");

  try {
    // First, upload a larger file for streaming demonstration
    logger.info("Uploading larger file for streaming demo...");
    const largeContent = "Large starship blueprint content\n".repeat(1000); // ~34KB

    await tailordb.file.upload(
      "galaxy",
      "Starship",
      "blueprint",
      starshipId,
      largeContent,
      { contentType: "text/plain" }
    );

    logger.info("Uploaded large file, now streaming download...");

    // Open stream using iterator pattern for efficient memory usage
    const stream = await tailordb.file.openDownloadStream(
      "galaxy",
      "Starship",
      "blueprint",
      starshipId
    );

    let totalBytes = 0;
    let chunkCount = 0;
    let streamMetadata: any = null;
    let reconstructedData: Uint8Array | null = null;
    let offset = 0;

    try {
      // Using for-await-of loop to process chunks as they arrive
      for await (const chunkResult of stream) {
        switch (chunkResult.type) {
          case 'metadata':
            streamMetadata = chunkResult.metadata;
            logger.info(`Stream started: ${chunkResult.metadata.fileSize} bytes`);
            logger.info(`Content type: ${chunkResult.metadata.contentType}`);

            // Pre-allocate buffer based on file size for maximum memory efficiency
            if (chunkResult.metadata.fileSize > 0) {
              reconstructedData = new Uint8Array(chunkResult.metadata.fileSize);
            }
            break;

          case 'chunk':
            const chunk = new Uint8Array(chunkResult.data);

            // Verify position matches expected next offset
            // position represents the end of this chunk in the file
            const expectedPosition = offset + chunk.length;
            if (chunkResult.position !== undefined && chunkResult.position !== expectedPosition) {
              throw new Error(
                `Position mismatch: expected ${expectedPosition} (offset ${offset} + chunk size ${chunk.length}), but got ${chunkResult.position}`
              );
            }

            totalBytes += chunk.length;
            chunkCount++;

            // Reconstruct data chunk by chunk
            if (reconstructedData) {
              reconstructedData.set(chunk, offset);
              offset += chunk.length;
            }

            logger.info(`Chunk ${chunkCount}: ${chunk.length} bytes at position ${chunkResult.position}`);
            break;

          case 'complete':
            logger.info(`Stream completed. Total: ${totalBytes} bytes in ${chunkCount} chunks`);
            break;
        }
      }

      // Verify the download
      const expectedSize = streamMetadata?.fileSize || 0;
      const isValid = expectedSize === 0 || totalBytes === expectedSize;

      if (!isValid) {
        logger.warn(`Size mismatch: expected ${expectedSize} bytes, got ${totalBytes} bytes`);
      }

      // Convert reconstructed data back to string for verification
      let reconstructedContent = "";
      if (reconstructedData && offset > 0) {
        const textDecoder = new TextDecoder();
        reconstructedContent = textDecoder.decode(reconstructedData.slice(0, offset));
      }

      return {
        message: "Streaming download completed successfully",
        totalBytes,
        chunkCount,
        metadata: streamMetadata,
        completed: true,
        isValid,
        contentPreview: reconstructedContent.substring(0, 100),
      };
    } finally {
      // Always cleanup stream resources
      await stream.close();
    }
  } catch (error) {
    logger.error("Error in streaming download:", error);

    return {
      message: "Streaming download failed",
      error: formatError(error),
    };
  }
};