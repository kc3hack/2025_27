<script>
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import './layout.css';
	import '$src/app.css';
	import Header from '$src/components/Header.svelte';
	
	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	<Header />
	<div class="main">{@render children()}</div>
	<footer class="footer w-full">
		<div class="flex"><p class="text-2xl">WARA1</p></div>
	</footer>
</ParaglideJS>

<style>
</style>
