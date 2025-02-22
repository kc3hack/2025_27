<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';

	const VOICEVOX_URL =
		import.meta.env.VITE_VOICEVOX_URL || 'https://voicevox-752169768124.asia-northeast2.run.app';

	let text = '';
	let audio = null;

	async function generateSpeech() {
		if (!text) return;

		const response = await fetch(
			`${VOICEVOX_URL}/audio_query?text=${encodeURIComponent(text)}&speaker=1`,
			{
				method: 'POST'
			}
		);

		if (!response.ok) {
			console.error('Failed to generate speech');
			return;
		}

		const queryData = await response.json();
		const synthesisResponse = await fetch(`${VOICEVOX_URL}/synthesis?speaker=1`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(queryData)
		});

		if (!synthesisResponse.ok) {
			console.error('Failed to synthesize speech');
			return;
		}

		const blob = await synthesisResponse.blob();
		audio.src = URL.createObjectURL(blob);
		audio.play();
	}

	onMount(async () => {
		if (browser) {
			audio = new Audio();
		}
	});
</script>

<main>
	<h1>Voicebox TTS</h1>
	<input type="text" bind:value={text} placeholder="Enter text..." />
	<button on:click={generateSpeech}>Speak</button>
</main>

<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 10px;
	}
</style>
