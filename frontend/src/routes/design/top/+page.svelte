<script>
    import { onMount, onDestroy } from "svelte";

	let name = '';

    let currentSlide = 0;
	const intervalTime = 3000; // 3秒ごとにスライド

	const slides = [
		{ img: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/640px-PNG_transparency_demonstration_1.png", text: "大喜利企画。" },
		{ img: "https://as2.ftcdn.net/v2/jpg/04/38/82/85/360_F_438828559_QccWdc3zAULf7uLTzekIt5XlOEnGj6X0.jpg", text: "テーマに沿った面白い回答を競い合う。" },
		{ img: "https://w7.pngwing.com/pngs/605/905/png-transparent-free-pic-web-design-label-text-thumbnail.png", text: "AIや観客が最も面白いと感じた回答に投票。" },
		{ img: "https://img.freepik.com/premium-psd/colorful-butterfly-realistic-isolated-transparent-background-png-file_1304044-3907.jpg?semt=ais_hybrid", text: "ポイントが高いほど優勝に近づくシステム。" },
		{ img: "https://img.freepik.com/premium-vector/free-vector-beautiful-flying-hummingbird-design-element-banners-posters-leaflets-brochur_1009653-1.jpg?semt=ais_hybrid", text: "最後に、最も多くのIPPONを獲得した者が勝者！" }
	];

	// 自動スライド開始
	onMount(() => {
		const interval = setInterval(() => {
			currentSlide = (currentSlide + 1) % slides.length;
		}, intervalTime);

		// コンポーネントが削除されたときに `setInterval` をクリア
		onDestroy(() => clearInterval(interval));
	});
</script>

<main class="content h-250 container mx-auto bg-amber-300 flex justify-between items-center">
	<!-- アバター、ニックネーム設定 -->
	<section class="col-6 user-setup text-4xl w-7/10 bg-amber-500">
		<p class="setup-text">アバターとニックネームを設定してください</p>
		<input type="text" bind:value={name} placeholder="名前を入力" />
		<!-- スタートボタン -->
        <button 
        on:click={() => console.log("")}
        class="px-6 bg-white text-lg rounded-md hover:bg-gray-200"
        >
        スタート
        </button>
	</section>

	<section class="col-6 how-to-use text-4xl w-3/10 bg-amber-800">
		<!-- 遊び方書く -->
		<h2>遊び方</h2>
		
        <!-- 説明文 -->
        <div class="bg-amber-700 p-4 rounded-md flex flex-col items-center"> 
            <!-- スライド画像 -->
			<div class="h-48 rounded-md">
				<img 
					src={slides[currentSlide].img} 
					alt="Slide Image" 
					class="w-full h-full object-cover"
				/>
			</div>

            <p class="text-lg text-white text-center mb-4">
                {slides[currentSlide].text}
            </p>

            <!-- スライド -->
            <div class="flex justify-center items-center space-x-2 mt-4">
				{#each slides as _, index}
					<div 
						class="cursor-pointer transition-colors duration-300 text-lg font-bold"
						class:text-white={currentSlide !== index}
						class:text-yellow-400={currentSlide === index}
						on:click={() => { currentSlide = index;}}
					>
						{currentSlide === index ? "◎" : "●"}
					</div>
				{/each}
			</div>
        </div>

        
	</section>
</main>

<style>
	.content {
	}

	.user-setup {
	}

	.setup-text {
	}

	.how-to-use {
	}
</style>
