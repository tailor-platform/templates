import { ComponentRegistry } from "@fabrix-framework/fabrix";
import { OMKSTable } from "./table";
import { OMKSField } from "./field";

export const omakaseFabrixComponents = new ComponentRegistry({
  default: {
    table: OMKSTable,
    field: OMKSField,
  },
});
