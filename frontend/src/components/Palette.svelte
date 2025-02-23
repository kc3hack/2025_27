<script>
	import { createEventDispatcher } from 'svelte';
	const dispatch = createEventDispatcher();
	
	let colors = [
		'#d58141',
		'#d7c44c',
		'#4fa9cc',
		'#3f8d27',
	]
	
	let paletteColor = colors[0]
	let background = '#fff'
</script>

<div>
	{#each colors as color}
	<button 
		on:click="{() => {
			dispatch('color', { color })
			paletteColor = color
		}}"
		style:background={color}
		class="w-10 h-10"
		>
	</button>
	{/each}
</div>

<button 
on:click={() => {
	dispatch('color', { color: background })
	paletteColor = background
}}
style:background
class="w-10 h-10">
	<span class="visually-hidden">
		<!-- Select the background color to clear the canvas -->
	</span>
</button>

<!-- Undoボタン追加 -->
<div class="flex justify-center mt-2">
	<button class="px-5 py-1 bg-yellow-500 text-white hover:bg-yellow-700">
		一つ前に戻る
	</button>
</div>

<style>
</style>