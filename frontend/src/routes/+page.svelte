<script>
	import UserSetup from '$src/components/UserSetup.svelte';
	import HowToUse from '$src/components/HowToUse.svelte';
	import Header from '$src/components/Header.svelte';


	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	let topAudio;

	if (browser) {
		topAudio = new Audio('/top_music.mp3');
	}
	onMount(async () => {
		if (browser) {
			setTimeout(() => {
				topAudio.play();
			}, 1000);
		}
	});
</script>

<Header />
<main class="content container mx-auto flex h-screen items-center justify-between">
	<section class="user-setup w-6/10 h-full" style="background-color: rgba(255, 165, 0, 0.5);">
		<UserSetup />
	</section>

	<section class="how-to-use w-4/10 h-full" style="background-color: rgba(200, 165, 0, 0.5);">
		<HowToUse />
	</section>
</main>

<style>
    body {
        background-image: url('/images/top_background.png'); /* 画像のパスを指定 */
        background-size: cover; /* 画面全体にカバー */
        background-position: center; /* 中央配置 */
        background-repeat: no-repeat; /* 繰り返しなし */
    }
</style>
