/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './app/**/*.{js,jsx,ts,tsx,md,mdx}',
        './content/**/*.{md,mdx}',

        // Or if using `src` directory:
        './src/**/*.{js,jsx,ts,tsx,md,mdx}'
    ],
    theme: {
        extend: {}
    },
    plugins: []
};
