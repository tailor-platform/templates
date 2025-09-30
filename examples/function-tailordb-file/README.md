# Tailor Platform TailorDB File Examples

This directory contains comprehensive examples of using the TailorDB File APIs in Tailor Platform Functions.

## Overview

The TailorDB File API provides powerful file management capabilities for your applications, allowing you to:
- Upload files of various types (text, binary, images)
- Download files with metadata
- Stream large files efficiently
- Manage file metadata and lifecycle
- Handle errors gracefully

This example demonstrates a complete workflow from record creation to file operations, mirroring real-world usage patterns.

## Prerequisites

This example assumes a star-wars application with the following schema:

### Required Schema

The Starship type has two File fields:

```cue
// star-wars application schema
Starship: {
  Fields: {
    name: { type: "String" }
    serialNumber: { type: "String" }
    status: { type: "String" }
    isArmed: { type: "Boolean" }
    crew: { type: "Int" }
    capacity: { type: "Int" }
    length: { type: "Float" }
  }
  Files: {
    blueprint: tailordb.#File & {
      Description: "Blueprint file of the starship"
    }
    thumbnail: tailordb.#File & {
      Description: "Thumbnail image of the starship"
    }
  }
}
```

## Example Files

This directory contains both individual operation examples and a complete workflow example:

### Individual Examples

Each file focuses on a specific File API operation:

- **setup.ts** - Create test record (preparation)
- **01-upload.ts** - Upload files (text and binary)
- **02-metadata.ts** - Get file metadata
- **03-download.ts** - Download files
- **04-streaming.ts** - Streaming download for large files
- **05-delete.ts** - Delete files

### Complete Workflow Example

`index.ts` provides a comprehensive example combining all operations.

### Running

#### Run the Complete Example
```bash
# Build
pnpm install
pnpm build

# Run
tailorctl workspace function test-run -a star-wars -m r2d2 -s 'dist/index.js'
```

## Appendix

- [Tailor Platform Documentation](https://docs.tailor.tech)