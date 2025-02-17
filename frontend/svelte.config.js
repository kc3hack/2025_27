import adapter from '@sveltejs/adapter-netlify';
const production = process.env.NODE_ENV === 'production';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		adapter: adapter(),
		alias: {
			"$src": "src"
		}
	}
};

export default config;
