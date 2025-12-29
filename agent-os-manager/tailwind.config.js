/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/renderer/**/*.{html,tsx,ts}'],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#1a73e8',
          dark: '#4a9eff'
        },
        global: {
          DEFAULT: '#34a853',
          dark: '#4caf50'
        },
        project: {
          DEFAULT: '#fbbc04',
          dark: '#ff9800'
        }
      }
    }
  },
  darkMode: 'class',
  plugins: []
}
