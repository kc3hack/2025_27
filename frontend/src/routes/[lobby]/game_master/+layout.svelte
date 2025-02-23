<script>
	import { i18n } from '$lib/i18n';
	import { ParaglideJS } from '@inlang/paraglide-sveltekit';
	import '$src/app.css';
	let { children } = $props();
</script>

<ParaglideJS {i18n}>
	<div class="main">{@render children()}</div>
</ParaglideJS>
