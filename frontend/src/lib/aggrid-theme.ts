import { themeQuartz } from "ag-grid-enterprise";

const baseThemeParams = {
  borderRadius: 2,
  fontFamily: {
    googleFont: "Inter",
  },
  fontSize: 13,
  headerFontSize: 14,
  spacing: 6,
  wrapperBorderRadius: 2,
};

export const darkTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#171717",
  foregroundColor: "#fafafa",
  rowHoverColor: "#262626",
  checkboxCheckedBackgroundColor: "#fff",
  checkboxCheckedShapeColor: "#0a0a0a",
  checkboxCheckedBorderColor: "#fff",
});

export const lightTheme = themeQuartz.withParams({
  ...baseThemeParams,
  backgroundColor: "#FFFFFF",
  foregroundColor: "#0a0a0a",
  rowHoverColor: "#f5f5f5",
  checkboxCheckedBackgroundColor: "#0a0a0a",
  checkboxCheckedShapeColor: "#fff",
  checkboxCheckedBorderColor: "#0a0a0a",
});
