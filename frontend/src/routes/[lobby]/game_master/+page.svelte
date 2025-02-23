<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import { connectWebSocket } from '$lib/chat.js';
	import { goto } from '$app/navigation';

	let socket;
	let lobbyId = '';
	let nickname = '';
	let selectAvatar = '';
	let players = [];
	let theme = '';
	let canvas;
	let ctx;
	let mode = 'theme';
	let img = null;

	function sendTheme() {
		socket.send(
			JSON.stringify({
				command: 'message',
				identifier: JSON.stringify({
					channel: 'GameChannel',
					room: lobbyId,
					nickname: localStorage.getItem('nickname'),
					select_avatar: localStorage.getItem('selectAvatar')
				}),
				data: JSON.stringify({ action: 'send_theme', theme: theme })
			})
		);
	}

	function sendEvaluate(evaluate) {
		socket.send(
			JSON.stringify({
				command: 'message',
				identifier: JSON.stringify({
					channel: 'GameChannel',
					room: lobbyId,
					nickname: localStorage.getItem('nickname'),
					select_avatar: localStorage.getItem('selectAvatar')
				}),
				data: JSON.stringify({ action: 'send_evaluate', evaluate: evaluate })
			})
		);
	}

	onMount(async () => {
		if (browser) {
			img = new Image();
			// @todo localstorageに値がなければトップにリダイレクト
			nickname = localStorage.getItem('nickname') || '';
			selectAvatar = localStorage.getItem('selectAvatar') || '';
			const user = {
				nickname: nickname,
				select_avatar: selectAvatar
			};
			lobbyId = $page.params.lobby;
			window.addEventListener('keydown', (e) => {
				if (e.key === 'ArrowLeft') {
					sendEvaluate(false);
				} else if (e.key === 'ArrowRight') {
					sendEvaluate(true);
				}
			});
			// WebSocket 接続
			socket = connectWebSocket('GameChannel', lobbyId, user, (message) => {
				console.log('message: ', message);
				if (message.type === 'text') {
					if (message.data.command === 'get_players') {
						console.log('get_players');
						console.log('message.data.players:', message.data.players);
						players = [...message.data.players];
					} else if (message.data.command === 'receive_image') {
						console.log('receive_image');
						mode = 'answer';
						img.src = message.data.image;
					} else if (message.data.command === 'set_theme') {
						console.log('set_theme: ', message.data.theme);
					} else if (message.data.command === 'continue_game') {
						console.log('continue_game');
						mode = 'theme';
					} else if (message.data.command === 'end_game') {
						console.log('end_game');
						if ($page.url.pathname.includes('design')) {
							goto(`/design/top/${lobbyId}/result`);
						} else {
							goto(`./result`);
						}
					}
				}
			});
		}
	});
</script>

<div class="theme-box bg-blue-500 px-10 py-10 text-center text-4xl">
	{#if mode === 'theme'}
		<textarea
			class="theme-box w-full bg-blue-500 text-center"
			placeholder="お題を入力"
			bind:value={theme}
			on:input={sendTheme}
		></textarea>
	{:else}
		<div class="flex justify-center">
			<img src={img.src} width={800} height={600} class="border bg-white" />
		</div>
	{/if}
</div>

<div class="answers-box flex bg-red-300">
	<div class="theme mx-auto w-2/3">
		<textarea class="theme-box w-full text-3xl" placeholder="お題を入力" bind:value={theme} disabled
		></textarea>
	</div>
	<div class="buttons flex w-1/3 items-center justify-around">
		<button
			class="btn rounded bg-gray-500 px-4 py-2 text-white"
			on:click={() => sendEvaluate(false)}
		>
			残念!
		</button>
		<button
			class="btn rounded bg-yellow-500 px-4 py-2 text-white"
			on:click={() => sendEvaluate(true)}
		>
			おもろい!
		</button>
	</div>
</div>
