import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],

  // https://vitejs.dev/config/#server-proxy
  // Configure custom proxy rules for the **dev server**.
  server: {
    proxy: {
      "/api": {
        target: "http://localhost:8010",
        changeOrigin: false,
      },
    },
  },
});
