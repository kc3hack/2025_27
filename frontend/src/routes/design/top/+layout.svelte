<script>
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	
	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	<div class="main">{@render children()}</div>
</ParaglideJS>

<style>
</style>
