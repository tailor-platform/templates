// Type guard to help with error handling
export function isError(error: unknown): error is Error {
  return error instanceof Error;
}

// Helper to format error for results
export function formatError(error: unknown) {
  if (error instanceof TailorDBFileError) {
    return {
      name: error.name,
      message: error.message,
      code: error.code,
    };
  }
  return {
    message: isError(error) ? error.message : String(error),
  };
}