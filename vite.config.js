import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  preview: {
    host: true,
    port: 3000,
    allowedHosts: [
      'ec2-54-196-61-59.compute-1.amazonaws.com',
      'localhost',
      '127.0.0.1'
    ]
  }
})