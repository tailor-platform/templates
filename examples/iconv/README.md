# Tailor Platform iconv Examples

This directory contains comprehensive examples of using the `tailor.iconv` APIs in Tailor Platform Functions.

## Overview

The iconv API provides character encoding conversion capabilities, allowing you to:
- Encode strings to different character encodings
- Decode byte arrays back to strings
- Convert between various character encodings
- Check encoding availability
- Handle encoding errors gracefully

## Examples Included

### Basic Operations
- **encode/decode**: Convert strings to/from UTF-8 encoded byte arrays
- **Japanese text handling**: Encode and decode Japanese characters

### Encoding Conversions
- **UTF-8 ↔ Shift_JIS**: Common Japanese encoding conversion
- **UTF-8 → HitachiKEIS90**: Special mainframe encoding with //IGNORE flag
- **UTF-8 → ISO-2022-JP**: Email-safe Japanese encoding
- **UTF-8 ↔ EUC-JP**: Unix-based Japanese encoding
- **UTF-8 ↔ UTF-16**: Unicode transformation format conversion
- **UTF-8 → ASCII**: With //IGNORE and //TRANSLIT flags for error handling

### Encoding Availability
- Check if specific encodings are available
- List all available encodings
- Verify support for:
  - EBCDIC-JP-E
  - EBCDIC-JP-KANA
  - IBM290
  - IBM930
  - And many more

## Setup

```bash
# Install dependencies
pnpm install

# Build the function
pnpm build
```

## API Reference

### `tailor.iconv.encode(text: string, encoding: string): Uint8Array`
Encodes a string into a byte array using the specified encoding.

### `tailor.iconv.decode(bytes: Uint8Array, encoding: string): string`
Decodes a byte array back to a string using the specified encoding.

### `tailor.iconv.convert(data: string | Uint8Array, fromEncoding: string, toEncoding: string): string | Uint8Array`
Converts data from one encoding to another.

### `tailor.iconv.getEncodingList(): string[]`
Returns a list of all available encodings.

## Error Handling Flags

- **//IGNORE**: Silently ignores characters that cannot be converted
- **//TRANSLIT**: Attempts to transliterate characters to similar ones in target encoding
- **Custom Replacement Characters (Extension)**: `//TRANSLIT:char` allows specifying custom replacement characters
  - Default: `//TRANSLIT` replaces unconvertible characters with `?`
  - Example: `ASCII//TRANSLIT:*` replaces unconvertible characters with `*`
  - Example: `ASCII//TRANSLIT:[?]` replaces unconvertible characters with `[?]`

## Usage Example

```javascript
// Basic encode/decode
const testString = "Hello, World!";
const encoded = tailor.iconv.encode(testString, "UTF-8");
const decoded = tailor.iconv.decode(encoded, "UTF-8");

// Special encoding conversion
const testString = "HELLO(コンニチハ)";
const encoded = tailor.iconv.convert(testString, "UTF-8", "HitachiKEIS90//IGNORE");
// Result: Byte array without unconvertible characters

// Transliteration example
const testString = "HELLOこんにちは";
const encoded = tailor.iconv.convert(testString, "UTF-8", "ASCII//TRANSLIT:*");
// Result: "HELLO*****"

// Check encoding availability
const encodingList = tailor.iconv.getEncodingList();
const hasEBCDICJPE = encodingList.includes("EBCDIC-JP-E");
```

## Notes

- The function returns a comprehensive results object showing all conversion examples
- Error handling is implemented for each conversion attempt
- Byte arrays are returned as arrays in the results for visibility
- The //IGNORE and //TRANSLIT flags help handle characters that don't exist in target encodings