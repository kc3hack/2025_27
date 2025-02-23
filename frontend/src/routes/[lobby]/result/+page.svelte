<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	let sponcerAudio;

	if (browser) {
		sponcerAudio = new Audio('/sponcer.wav');
	}
	onMount(async () => {
		if (browser) {
			setTimeout(() => {
				sponcerAudio.play();
			}, 5000);
		}
	});
</script>

<h1>Result</h1>
