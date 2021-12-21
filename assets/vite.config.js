export default {
  publicDir: "./static",
  build: {
    target: "es2018",
    minify: true,
    outDir: "../priv/static",
    emptyOutDir: true,
    assetsInlineLimit: 0,
    rollupOptions: {
      input: ["./core.css", "app/styles/main.scss", "./core.js", "app/app.ts"],
      output: {
        entryFileNames: "dist/[name].js",
        chunkFileNames: "dist/[name].js",
        assetFileNames: "dist/[name][extname]"
      }
    },
  }
}