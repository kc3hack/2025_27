<script>
	import Palette from './Palette.svelte';

	const colors = ['#d58141', '#d7c44c', '#4fa9cc', '#3f8d27'];
	const background = '#fff';

	let color = colors[0];
	const paletteColor = color;
</script>

<main class="content h-250 container mx-auto flex flex-col bg-amber-300">
	<!-- お題表示の部分 -->
	<section class="p-15 w-full rounded-md bg-yellow-500 text-center text-5xl text-black">
		お題:ボウリングで全ての投球がガターだった時、起こることは？
	</section>

	<!-- お絵描き部分 -->
	<div class="Drawing section w-1/2 bg-amber-600">
		<div class="palette w-1/2 bg-amber-500">
			<Palette
				{paletteColor}
				{colors}
				{background}
				on:color={({ detail }) => {
					color = detail.color;
				}}
			/>
		</div>
	</div>

	<!-- 発表部分 -->
	<div class="fixed bottom-20 right-1 flex justify-end bg-amber-200 p-5">
		<button class="rounded-md bg-yellow-600 px-10 py-3 text-4xl text-white hover:bg-orange-200">
			発表する！
		</button>
	</div>
</main>
