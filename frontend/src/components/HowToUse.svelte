<script>
	import { onMount, onDestroy } from 'svelte';
	let currentSlide = 0;
	const intervalTime = 3000; // 3秒ごとにスライド

	const slides = [
		{
			img: 'https://devroom.azurewebsites.net/Images/Generator/Ippon/RYOMA_SAKAMOTO.jpg',
			text: 'IPPONグランプリの素人版'
		},
		{
			img: 'https://freeneko-sozai.work/wp-content/uploads/hobby/game-0006-vsscreen.png',
			text: 'テーマに沿った面白い回答を競い合う'
		},
		{
			img: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgTB1PI2HkDy3DlZqkANiEYP7DNcsgdFMcRBt2ecz5dPS8Hxnfk7aXXs2ggDnOIS6QVyiimLaQB-i-OR6vnWmzqnI3JOSVAkq7XXI3DoVv8ni7qgCzeJPXyRsuZxvX3hu7KJ2iyKpd4AMWU/s1600/tv_panel_quiz_woman.png',
			text: '大喜利が出題されるので、フリップに書き早押しで回答'
		},
		{
			img: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVrmjydIaCxB4Y6yHiua7GwTHICdHA5VtUd_PppvmisKH_MGQQ9JXkP5bJdADDbfSsg3iTTsCyhM284Scr2How_QVwxI4vR2NNZ0pdmhmBmIuOesHhfXaYskbqKVtmW7RAKU6nUk8NLoap/s1600/pose_warau_kuchi_kakusu_man.png',
			text: '審査員(マスター)が面白いと思えばボタンを右矢印を押す'
		},
		{
			img: 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiikxS4tlKLKVOkkAqZVYK7V_idCF-mggqn3MA4MP50IUb3MONiZhmwk6qvFFYZfw_j70B5yQRcYz9L20qG6Xap1fHiD_-YmDD_PAKckTId-EOwVoD_SIa1Mp7UleNHnBdSDtpyOGnto2M/s800/pose_win_boy.png',
			text: '先にどちらかがIPPONを取ったら勝ち！'
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
<!-- 説明文 -->
<div class="flex flex-col items-center ">
	<!-- スライド画像 -->
	<div class="w-3/5 h-auto rounded-md mt-20 overflow-hidden">
		<img src={slides[currentSlide].img} alt="Slide Image" class="h-full w-full object-cover" />
	</div>

	<p class="mb-4 text-center text-3xl text-black">
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

