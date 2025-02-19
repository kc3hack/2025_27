<script>
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import './layout.css';
	import '$src/app.css';
	import Header from '$src/components/Header.svelte';
	import Footer from '$src/components/Footer.svelte';
	
	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	<Header />
	<div class="main">{@render children()}</div>
	<Footer />
</ParaglideJS>

<style>
</style>
