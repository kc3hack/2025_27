<script>
	import { nickname, selectAvatar } from '$lib/stores.js';
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { goto } from '$app/navigation';

	let currentStep = 0;

	const steps = [
		'ここに説明01',
		'ここに説明02',
		'ここに説明03',
		'ここに説明04',
		'ここに説明05',
		'ここに説明06'
	];

	function nextStep() {
		currentStep = (currentStep + 1) % steps.length;
	}

	const avatarUrls = [
		'https://flowbite.com/docs/images/people/profile-picture-1.jpg',
		'https://flowbite.com/docs/images/people/profile-picture-2.jpg',
		'https://flowbite.com/docs/images/people/profile-picture-3.jpg',
		'https://flowbite.com/docs/images/people/profile-picture-4.jpg',
		'https://flowbite.com/docs/images/people/profile-picture-5.jpg'
	];

	function nextAvatar() {
		selectAvatar.set(avatarUrls[(avatarUrls.indexOf($selectAvatar) + 1) % avatarUrls.length]);
	}

	function startLobby() {
		let lobbyId = Math.floor(Math.random() * 1000);
		goto(`${lobbyId}`);
	}

	onMount(() => {
		if (browser) {
			nickname.set(localStorage.getItem('nickname') || '');
			selectAvatar.set(localStorage.getItem('selectAvatar') || avatarUrls[0]);
		}
	});
</script>

<main class="content h-250 container mx-auto flex items-center justify-between bg-amber-300">
	<section class="user-setup w-7/10 bg-amber-500">
		<div class="flex items-center justify-center gap-4">
			<img class="h-40 w-40 rounded-full" src={$selectAvatar} alt="" on:click={nextAvatar} />
			<div class="font-medium dark:text-white">
				<p class="setup-text">アバターとニックネームを設定してください</p>
				<input
					type="text"
					bind:value={$nickname}
					placeholder="名前を入力"
					class="rounded-lg border-2 border-gray-300 p-2"
				/>
			</div>
		</div>
		<div class="flex items-center justify-center">
			<button on:click={startLobby} class="rounded-md bg-white px-6 text-lg hover:bg-gray-200">
				スタート
			</button>
		</div>
	</section>

	<section class="how-to-use w-3/10 bg-amber-800 text-4xl">
		<!-- 遊び方書く -->
		<h2>遊び方</h2>
		<p>ここに説明書く</p>
		<div class="flex flex-col items-center rounded-md bg-amber-700 p-4">
			<!-- 説明文 -->
			<p class="mb-4 text-center text-lg text-white">
				{steps[currentStep]}
			</p>

			<!-- 次へボタン -->
			<button on:click={nextStep} class="rounded-md bg-white px-6 text-lg hover:bg-gray-200">
				次へ
			</button>
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
