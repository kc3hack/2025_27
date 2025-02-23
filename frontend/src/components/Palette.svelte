<script>
	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher();

	let colors = ['#d58141', '#d7c44c', '#4fa9cc', '#3f8d27', '#000', '#fff'];
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
		width: 40px;
		height: 40px;
		border: none;
		cursor: pointer;
		border-radius: 50%;
	}

	.color-button:focus {
		outline: 2px solid #000;
	}
</style>
