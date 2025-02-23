<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	let sponcerAudio;

	if (browser) {
		sponcerAudio = new Audio('/sponcer.wav');
	}
	onMount(async () => {
		if (browser) {
			setTimeout(() => {
				sponcerAudio.play();
			}, 5000);
		}
	});
</script>

<section>
	<div
		class="md:h-150 h-200 relative mx-10 mt-10 flex items-center justify-center bg-center bg-no-repeat py-10"
	>
		<img
			class="h-100 w-100 absolute rounded-full"
			src="https://flowbite.com/docs/images/people/profile-picture-1.jpg"
			alt=""
			style="top: 50%; left: 50%; transform: translate(-50%, -50%);"
		/>
		<div
			class="absolute rounded-lg bg-yellow-400 px-6 py-2 text-6xl font-bold text-black shadow-lg"
			style="top: 90%; left: 50%; transform: translate(-50%, -50%);"
		>
			プレイヤー名
		</div>
		<img src="/images/champion_background.png" class="mx-auto" />
	</div>
</section>

<section class="overflow-hidden">
	<div class="relative mx-10 h-full bg-gray-800 py-10 text-7xl">
		<!-- エンドロール -->

		<div class="marquee-container">
			<div class="marquee-content">
				<!-- 画像 -->
				<img src="/images/dmm.png" class="mx-5 h-40 w-auto" />
				<img src="/images/tgl.png" class="mx-5 h-40 w-auto" />
				<img src="/images/sakura.png" class="mx-5 h-40 w-auto" />
				<img src="/images/smartHR.png" class="mx-5 h-40 w-auto" />
				<img src="/images/stores.png" class="mx-5 h-40 w-auto" />
				<img src="/images/yumemi.png" class="mx-5 h-40 w-auto" />
				<img src="/images/engineerGuild.png" class="mx-5 h-40 w-auto" />
				<img src="/images/Dimps.png" class="mx-5 h-40 w-auto" />
				<img src="/images/job.png" class="mx-5 h-40 w-auto" />

				<!-- テキスト -->
				<p class="mx-5 inline-block text-nowrap text-5xl font-bold text-yellow-300">yamaguchi</p>
				<p class="mx-5 inline-block text-nowrap text-5xl font-bold text-yellow-300">takami</p>
				<p class="mx-5 inline-block text-nowrap text-5xl font-bold text-yellow-300">takaoka</p>
			</div>
		</div>
	</div>
</section>

<style>
	.marquee-container {
		overflow: hidden;
		display: flex;
		width: 100%;
	}

	.marquee-content {
		display: flex;
		align-items: center;
		animation: marquee 25s linear infinite;
	}

	@keyframes marquee {
		from {
			transform: translateX(100%);
		}
		to {
			transform: translateX(-600%);
		}
	}

	.text-nowrap {
		white-space: nowrap;
	}
</style>
