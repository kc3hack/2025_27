<script>
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import '$src/app.css';
	// ページコンテンツを受け取る
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	<header class="header w-full">
		<div class="flex justify-center"><h1 class="text-4xl">WARA1</h1></div>
	</header>
	<div class="main">{@render children()}</div>
	<footer class="footer w-full">
		<div class="flex"><p class="text-2xl">WARA1</p></div>
	</footer>
</ParaglideJS>

<style>
</style>
