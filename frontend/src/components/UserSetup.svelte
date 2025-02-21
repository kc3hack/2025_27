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
		let lobbyId = Math.floor(Math.random() * 1000);
		goto(`${$page.url.pathname}/${lobbyId}`);
	}

	onMount(() => {
		if (browser) {
			nickname.set(localStorage.getItem('nickname') || '');
			selectAvatar.set(localStorage.getItem('selectAvatar') || avatarUrls[0]);
		}
	});
</script>

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
