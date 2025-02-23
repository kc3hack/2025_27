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

	function startGame() {
		socket.send(
			JSON.stringify({
				command: 'message',
				identifier: JSON.stringify({
					channel: 'LobbyChannel',
					room: lobbyId,
					nickname: localStorage.getItem('nickname'),
					select_avatar: localStorage.getItem('selectAvatar')
				}),
				data: JSON.stringify({ action: 'start_game', nickname: localStorage.getItem('nickname') })
			})
		);
	}

	function inviteLink() {
		const url = `${$page.url.origin}?roomId=${lobbyId}`;
		navigator.clipboard
			.writeText(url)
			.then(() => {
				alert('コピーしました: ' + url);
			})
			.catch((err) => {
				console.error('コピーに失敗しました', err);
			});
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
			socket = connectWebSocket('LobbyChannel', lobbyId, user, (message) => {
				console.log('message: ', message);
				if (message.type === 'text') {
					if (message.data.command === 'get_players') {
						console.log('message.data.players:', message.data.players);
						players = [...message.data.players];
					} else if (message.data.command === 'start_game') {
						console.log('start_game!');
						if ($page.url.pathname.includes('design')) {
							goto(`/design/top/${lobbyId}/game_answer`);
						} else {
							if (message.data.game_master === nickname) {
								goto(`${lobbyId}/game_master`);
							} else {
								goto(`${lobbyId}/game_answer`);
							}
						}
					}
				}
			});
		}
	});
</script>

<h1>Lobby</h1>
<p>lobbyId: {lobbyId}</p>
{#each players as _, index}
	<p>player{index + 1}: {_.nickname} {_.image}</p>
{/each}
<p>nickname: {nickname}</p>
<p>selectAvata: {selectAvatar}</p>

<button on:click={startGame}>start_game</button>
<button on:click={inviteLink}>invite link</button>
