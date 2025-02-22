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
	let drawing = false;

	function startDrawing(event) {
		drawing = true;
		ctx.beginPath();
		ctx.moveTo(event.offsetX, event.offsetY);
	}

	function draw(event) {
		if (!drawing) return;
		ctx.lineTo(event.offsetX, event.offsetY);
		ctx.stroke();
	}

	function stopDrawing() {
		drawing = false;
		ctx.closePath();
	}

	onMount(async () => {
		if (browser) {
			ctx = canvas.getContext('2d');
			ctx.lineWidth = 5;
			ctx.lineCap = 'round';

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
						theme = message.data.theme;
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

<h1>Game Answer</h1>

<h1>{theme}</h1>

<canvas
	bind:this={canvas}
	width={800}
	height={600}
	on:mousedown={startDrawing}
	on:mousemove={draw}
	on:mouseup={stopDrawing}
	on:mouseleave={stopDrawing}
	class="border"
>
</canvas>

<style>
	canvas {
		border: 1px solid #000;
		cursor: crosshair;
	}
</style>
