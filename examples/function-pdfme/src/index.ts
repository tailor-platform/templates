import { BLANK_PDF, Template } from "@pdfme/common";
import { generate } from "@pdfme/generator";
import base64 from "base64-js";

export default async () => {
  const template: Template = {
    basePdf: BLANK_PDF,
    schemas: [
      [
        {
          name: "a",
          type: "text",
          position: { x: 0, y: 0 },
          width: 10,
          height: 10,
        },
        {
          name: "b",
          type: "text",
          position: { x: 10, y: 10 },
          width: 10,
          height: 10,
        },
        {
          name: "c",
          type: "text",
          position: { x: 20, y: 20 },
          width: 10,
          height: 10,
        },
      ],
    ],
  };
  const inputs = [{ a: "a1", b: "b1", c: "c1" }];
  const data = await generate({ template, inputs });

  return { data: base64.fromByteArray(data) };
};
