export default async () => {
  console.log("Starting iconv examples");
  
  const results: Record<string, any> = {};

  try {
    console.log("=== Basic Encode/Decode Example ===");
    const testString = "Hello, 世界! こんにちは";
    const encoded = tailor.iconv.encode(testString,"SHIFT-JIS");
    console.log(`Encoded "${testString}" to UTF-8:`, encoded);
    results.basicEncode = { input: testString, encoded: Array.from(encoded) };

    const decoded = tailor.iconv.decode(encoded, "SHIFT-JIS");
    console.log(`Decoded back to string: "${decoded}"`);
    results.basicDecode = { encoded: Array.from(encoded), decoded };

  } catch (error) {
    console.error("Error in basic encode/decode:", error);
    results.basicError = error;
  }

  try {
    console.log("\n=== Japanese Text Encode/Decode ===");
    const japaneseText = "こんにちは世界";
    const japaneseEncoded = tailor.iconv.encode(japaneseText, "SHIFT-JIS");
    console.log(`Encoded Japanese "${japaneseText}":`, japaneseEncoded);
    results.japaneseEncode = { input: japaneseText, encoded: Array.from(japaneseEncoded) };

    const japaneseDecoded = tailor.iconv.decode(japaneseEncoded, "SHIFT-JIS");
    console.log(`Decoded Japanese: "${japaneseDecoded}"`);
    results.japaneseDecode = { decoded: japaneseDecoded };

  } catch (error) {
    console.error("Error in Japanese encode/decode:", error);
    results.japaneseError = error;
  }

  try {
    console.log("\n=== Special Encoding: HitachiKEIS90 ===");
    const testStringKEIS = "HELLO(コンニチハ)";
    console.log(`Converting "${testStringKEIS}" from UTF-8 to HitachiKEIS90`);

    const convertedKEIS = tailor.iconv.convert(testStringKEIS, "UTF-8", "HitachiKEIS90//IGNORE");
    console.log("Converted to HitachiKEIS90:", convertedKEIS);
    results.hitachiKEIS90 = {
      input: testStringKEIS,
      fromEncoding: "UTF-8",
      toEncoding: "HitachiKEIS90//IGNORE",
      output: Array.from(convertedKEIS)
    };

  } catch (error) {
    console.error("Error in HitachiKEIS90 conversion:", error);
    results.hitachiKEIS90Error = error;
  }

  try {
    console.log("\n=== Convert Between Different Encodings ===");
    const mixedText = "ABC123あいうえお";

    const shiftJIS = tailor.iconv.convert(mixedText, "UTF-8", "Shift_JIS");
    console.log(`Converted "${mixedText}" to Shift_JIS:`, shiftJIS);
    results.toShiftJIS = {
      input: mixedText,
      output: Array.from(shiftJIS)
    };

    const backToUTF8 = tailor.iconv.convert(shiftJIS, "Shift_JIS", "UTF-8");
    console.log(`Converted back to UTF-8: "${backToUTF8}"`);
    results.fromShiftJIS = {
      input: Array.from(shiftJIS),
      output: backToUTF8
    };

  } catch (error) {
    console.error("Error in encoding conversion:", error);
    results.conversionError = error;
  }

  try {
    console.log("\n=== Check Encoding Availability ===");
    const encodingList = tailor.iconv.encodings();
    console.log(`Total available encodings: ${encodingList.length}`);

    const hasUTF8 = encodingList.includes("UTF-8");
    const hasEBCDICJPE = encodingList.includes("EBCDIC-JP-E");
    const hasEBCDICJPKANA = encodingList.includes("EBCDIC-JP-KANA");
    const hasIBM290 = encodingList.includes("IBM290");
    const hasIBM930 = encodingList.includes("IBM930");
    const hasShiftJIS = encodingList.includes("Shift_JIS");
    const hasUTF16 = encodingList.includes("UTF-16");
    const hasISO2022JP = encodingList.includes("ISO-2022-JP");

    results.encodingAvailability = {
      totalEncodings: encodingList.length,
      "UTF-8": hasUTF8,
      "EBCDIC-JP-E": hasEBCDICJPE,
      "EBCDIC-JP-KANA": hasEBCDICJPKANA,
      "IBM290": hasIBM290,
      "IBM930": hasIBM930,
      "Shift_JIS": hasShiftJIS,
      "UTF-16": hasUTF16,
      "ISO-2022-JP": hasISO2022JP
    };

    console.log("Encoding availability check:", results.encodingAvailability);

    console.log("\n=== Sample of available encodings ===");
    const sampleEncodings = encodingList.slice(0, 10);
    console.log("First 10 encodings:", sampleEncodings);
    results.sampleEncodings = sampleEncodings;

  } catch (error) {
    console.error("Error checking encoding availability:", error);
    results.encodingCheckError = error;
  }

  try {
    console.log("\n=== ISO-2022-JP Conversion Example ===");
    const emailText = "Subject: テストメール";
    const iso2022jp = tailor.iconv.convert(emailText, "UTF-8", "ISO-2022-JP");
    console.log(`Converted "${emailText}" to ISO-2022-JP (common for emails):`, iso2022jp);
    results.iso2022jp = {
      input: emailText,
      output: Array.from(iso2022jp)
    };

  } catch (error) {
    console.error("Error in ISO-2022-JP conversion:", error);
    results.iso2022jpError = error;
  }

  try {
    console.log("\n=== EUC-JP Conversion Example ===");
    const webText = "ウェブページのテキスト";
    const eucjp = tailor.iconv.convert(webText, "UTF-8", "EUC-JP");
    console.log(`Converted "${webText}" to EUC-JP:`, eucjp);
    results.eucjp = {
      input: webText,
      output: Array.from(eucjp)
    };

    const eucjpBack = tailor.iconv.convert(eucjp, "EUC-JP", "UTF-8");
    console.log(`Converted back from EUC-JP: "${eucjpBack}"`);
    results.eucjpBack = eucjpBack;

  } catch (error) {
    console.error("Error in EUC-JP conversion:", error);
    results.eucjpError = error;
  }

  try {
    console.log("\n=== UTF-16 Conversion Example ===");
    const unicodeText = "Unicode: 🌍🚀 日本語";
    const utf16 = tailor.iconv.convert(unicodeText, "UTF-8", "UTF-16");
    console.log(`Converted "${unicodeText}" to UTF-16:`, utf16);
    results.utf16 = {
      input: unicodeText,
      output: Array.from(utf16)
    };

    const utf16Back = tailor.iconv.convert(utf16, "UTF-16", "UTF-8");
    console.log(`Converted back from UTF-16: "${utf16Back}"`);
    results.utf16Back = utf16Back;

  } catch (error) {
    console.error("Error in UTF-16 conversion:", error);
    results.utf16Error = error;
  }

  try {
    console.log("\n=== Error Handling with //IGNORE flag ===");
    const problematicText = "Text with 特殊文字 that might not exist in target encoding";

    const withIgnore = tailor.iconv.convert(problematicText, "UTF-8", "ASCII//IGNORE");
    console.log(`Converted to ASCII with //IGNORE flag: "${withIgnore}"`);
    results.withIgnore = {
      input: problematicText,
      output: btoa(String.fromCharCode(...new Uint8Array(withIgnore))),
      note: "Non-ASCII characters were ignored"
    };

  } catch (error) {
    console.error("Error in conversion with //IGNORE:", error);
    results.ignoreError = error;
  }

  try {
    console.log("\n=== Error Handling with //TRANSLIT flag ===");
    const textToTranslit = "Café résumé naïve";

    const withTranslit = tailor.iconv.convert(textToTranslit, "UTF-8", "ASCII//TRANSLIT");
    console.log(`Converted to ASCII with //TRANSLIT flag: "${withTranslit}"`);
    results.withTranslit = {
      input: textToTranslit,
      output: btoa(String.fromCharCode(...new Uint8Array(withTranslit))),
      note: "Special characters were transliterated"
    };

  } catch (error) {
    console.error("Error in conversion with //TRANSLIT:", error);
    results.translitError = error;
  }

  console.log("\n=== All Examples Completed ===");

  return {
    message: "iconv examples executed successfully",
    results: results
  };
};