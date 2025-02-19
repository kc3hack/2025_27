<script>
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { connectWebSocket } from '$lib/chat.js';
	let socket;
	let lobbyId = '';
	let players = [];

	onMount(async () => {
		// lobbyId を取得
		lobbyId = $page.params.lobby;

		// WebSocket 接続
		socket = connectWebSocket(lobbyId, 'aaaaaa', (message) => {
			console.log('message: ', message);
			if (message.type === 'text') {
				if (message.data.command === 'get_players') {
					console.log('message.data.players:', message.data.players);
					players = [...message.data.players];
				} else if (message.data.command === 'start_game') {
					console.log('start_game!');
				}
			}
		});
	});
</script>

<h1>Lobby</h1>
