<script>
// @ts-nocheck

    import { onMount, onDestroy } from "svelte";
	import UserSetup from "$src/components/UserSetup.svelte";
    import HowToUse from "$src/components/HowToUse.svelte"; // コンポーネントをインポート

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

<main class="content h-250 container mx-auto bg-amber-300 flex justify-between items-center">
	<!-- アバター、ニックネーム設定 -->
	<UserSetup {name}/>

    <!-- 遊び方説明-->
    <HowToUse {slides} {currentSlide} {setCurrentSlide} />
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
