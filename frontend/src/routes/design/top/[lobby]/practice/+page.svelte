<script>
	import Palette from '$src/components/Palette.svelte';

	const colors = ['#d58141', '#d7c44c', '#4fa9cc', '#3f8d27'];
	const background = '#fff';

	let color = colors[0];
	const paletteColor = color;
</script>

<section>
	<div class="mx-10 mt-10 h-60 bg-blue-800 py-10">
		<div class="mx-10 h-full bg-purple-400"></div>
	</div>
</section>

<section class="mx-10 mt-10 bg-yellow-500 py-10">
	<div class="h-120 mx-10 flex bg-red-500 px-10 py-10">
		<div class="canvas w-7/10 mr-4 h-full bg-red-400"></div>

		<div class="menu w-3/10 flex h-full flex-col bg-red-100">
			<Palette />
			<div class="happyou mt-auto flex h-10 w-full bg-purple-700"></div>
		</div>
	</div>
</section>
