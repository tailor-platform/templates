import esbuild from "esbuild";
import { createConfig } from "@tailor-terraform-modules/esbuild-config";

const config = createConfig();
esbuild.build(config).catch(() => {
    // eslint-disable-next-line no-undef
    process.exit(1);
});