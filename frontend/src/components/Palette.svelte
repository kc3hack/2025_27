<script>
	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher();

	let colors = ['#ff0000', '#eaff00', '#001eff', '#00ff40', '#000', '#fff'];
	let paletteColor = colors[0];
</script>

<div class="palette-container">
	{#each colors as color}
		<button
			on:click={() => {
				dispatch('color', { color });
				paletteColor = color;
			}}
			style="background: {color}"
			class="color-button"
		>
		</button>
	{/each}
</div>

<style>
	.palette-container {
		display: flex;
		gap: 10px;
	}

	.color-button {
		width: 50px;
		height: 50px;
		border: none;
		cursor: pointer;
		border-radius: 50%;
	}

	.color-button:focus {
		outline: 2px solid #000;
	}
</style>
