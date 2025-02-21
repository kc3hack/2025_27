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

	onMount(async () => {
		if (browser) {
			// @todo localstorageに値がなければトップにリダイレクト
			nickname = localStorage.getItem('nickname') || '';
			selectAvatar = localStorage.getItem('selectAvatar') || '';
			const user = {
				nickname: nickname,
				select_avatar: selectAvatar
			};
			lobbyId = $page.params.lobby;

			// WebSocket 接続
			socket = connectWebSocket('GameChannel', lobbyId, user, (message) => {
				console.log('message: ', message);
				if (message.type === 'text') {
					if (message.data.command === 'get_players') {
						console.log('message.data.players:', message.data.players);
						players = [...message.data.players];
					} else if (message.data.command === 'set_theme') {
						console.log('set_theme: ', message.data.theme);
					} else if (message.data.command === 'end_game') {
						console.log('end_game');
						if ($page.url.pathname.includes('design')) {
							goto(`/design/top/${lobbyId}/result`);
						} else {
							goto(`${lobbyId}/result`);
						}
					}
				}
			});
		}
	});
</script>

<h1>Game Master</h1>

<input type="text" bind:value={theme} on:input={sendTheme} placeholder="Enter theme" />
