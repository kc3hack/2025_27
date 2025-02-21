<script>
	import { onMount, onDestroy } from 'svelte';
	let currentSlide = 0;
	const intervalTime = 3000; // 3秒ごとにスライド

	const slides = [
		{
			img: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/640px-PNG_transparency_demonstration_1.png',
			text: '大喜利企画。'
		},
		{
			img: 'https://as2.ftcdn.net/v2/jpg/04/38/82/85/360_F_438828559_QccWdc3zAULf7uLTzekIt5XlOEnGj6X0.jpg',
			text: 'テーマに沿った面白い回答を競い合う。'
		},
		{
			img: 'https://w7.pngwing.com/pngs/605/905/png-transparent-free-pic-web-design-label-text-thumbnail.png',
			text: 'AIや観客が最も面白いと感じた回答に投票。'
		},
		{
			img: 'https://img.freepik.com/premium-psd/colorful-butterfly-realistic-isolated-transparent-background-png-file_1304044-3907.jpg?semt=ais_hybrid',
			text: 'ポイントが高いほど優勝に近づくシステム。'
		},
		{
			img: 'https://img.freepik.com/premium-vector/free-vector-beautiful-flying-hummingbird-design-element-banners-posters-leaflets-brochur_1009653-1.jpg?semt=ais_hybrid',
			text: '最後に、最も多くのIPPONを獲得した者が勝者！'
		}
	];

	// スライドを更新する関数　追加
	function setCurrentSlide(index) {
		currentSlide = index;
	}

	// 自動スライド開始
	onMount(() => {
		const interval = setInterval(() => {
			currentSlide = (currentSlide + 1) % slides.length;
		}, intervalTime);

		// コンポーネントが削除されたときに `setInterval` をクリア
		onDestroy(() => clearInterval(interval));
	});
</script>

<h2>遊び方</h2>
<!-- 説明文 -->
<div class="flex flex-col items-center rounded-md bg-amber-700 p-4">
	<!-- スライド画像 -->
	<div class="h-48 rounded-md">
		<img src={slides[currentSlide].img} alt="Slide Image" class="h-full w-full object-cover" />
	</div>

	<p class="mb-4 text-center text-lg text-white">
		{slides[currentSlide].text}
	</p>

	<!-- スライド -->
	<div class="mt-4 flex items-center justify-center space-x-2">
		{#each slides as _, index}
			<div
				class="cursor-pointer text-lg font-bold transition-colors duration-300"
				class:text-white={currentSlide !== index}
				class:text-yellow-400={currentSlide === index}
				on:click={() => setCurrentSlide(index)}
			>
				{currentSlide === index ? '◎' : '●'}
			</div>
		{/each}
	</div>
</div>
