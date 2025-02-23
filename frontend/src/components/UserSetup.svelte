<script>
	import { nickname, selectAvatar } from '$lib/stores.js';
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';

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
		const urlParams = new URLSearchParams(window.location.search);
		const roomId = urlParams.get('roomId');
		let lobbyId = roomId || Math.floor(Math.random() * 1000);

		if ($page.url.pathname.includes('design')) {
			goto(`/design/top/${lobbyId}`);
		} else {
			goto(`${lobbyId}`);
		}
	}

	onMount(() => {
		if (browser) {
			nickname.set(localStorage.getItem('nickname') || '');
			selectAvatar.set(localStorage.getItem('selectAvatar') || avatarUrls[0]);
		}
	});
</script>

<div class="h-120 flex items-center justify-center gap-4">
	<img class="h-60 w-60 rounded-full" src={$selectAvatar} alt="" on:click={nextAvatar} />
	<div class="font-medium dark:text-black">
		<p class="setup-text text-3xl">アバターとニックネームを設定してください</p>
		<input
			type="text"
			bind:value={$nickname}
			placeholder="名前を入力"
			class="rounded-lg border-2 text-2xl border-gray-300 p-2"
		/>
	</div>
</div>
<div class="flex items-center justify-center">
	<button on:click={startLobby} class="rounded-md bg-white text-4xl px-6 hover:bg-gray-200">
		スタート
	</button>
</div>
