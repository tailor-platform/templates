import * as esbuild from 'esbuild';

await esbuild.build({
  entryPoints: ['src/index.ts'],
  bundle: true,
  minify: true,
  platform: 'neutral',
  outfile: 'dist/index.js',
  format: 'esm',
  target: 'es2020',
});