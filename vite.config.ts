import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: { allowedHosts: ['.us3.manus.computer'] },
  preview: { allowedHosts: ['.us3.manus.computer'] },
  build: {
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom', 'react-dom/client'],
          'supabase-vendor': ['@supabase/supabase-js'],
        },
      },
    },
  },
});
