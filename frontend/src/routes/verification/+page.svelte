<script>
	import { onMount } from 'svelte';
	let text = '';
	let audio = new Audio();
	const voiceboxUrl = 'http://localhost:50021';

	async function generateSpeech() {
		if (!text) return;

		const response = await fetch(
			`${voiceboxUrl}/audio_query?text=${encodeURIComponent(text)}&speaker=1`,
			{
				method: 'POST'
			}
		);

		if (!response.ok) {
			console.error('Failed to generate speech');
			return;
		}

		const queryData = await response.json();
		const synthesisResponse = await fetch(`${voiceboxUrl}/synthesis?speaker=1`, {
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
