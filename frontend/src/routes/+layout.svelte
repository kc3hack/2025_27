<script>
	import { i18n } from '$lib/i18n';
	import { page } from '$app/stores';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import '$src/app.css';
	

	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
		<div class="main">{@render children()}</div>
</ParaglideJS>

<style>
</style>
