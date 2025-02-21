<script>
	import { i18n } from '$lib/i18n';
	import { page } from '$app/stores';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import '$src/app.css';
	import Header from '$src/components/Header.svelte';
	import Footer from '$src/components/Footer.svelte';

	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	{#if $page.url.pathname.includes('game_answer') || $page.url.pathname.includes('game_master') || $page.url.pathname.includes('result')}
		<div class="main">{@render children()}</div>
	{:else}
		<Header />
		<div class="main">{@render children()}</div>
		<Footer />
	{/if}
</ParaglideJS>

<style>
</style>
