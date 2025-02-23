<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import { connectWebSocket } from '$lib/chat.js';
	import { goto } from '$app/navigation';
	import Palette from '$src/components/Palette.svelte';

	const BACKEND_URL = import.meta.env.VITE_BACKEND_URL || 'wss://wara1-backend.onrender.com';

	let socket;
	let lobbyId = '';
	let nickname = '';
	let selectAvatar = '';
	let players = [];
	let theme = '';
	let selectedColor = '#000';
	let isAnswering = false;

	let canvas;
	let ctx;
	let drawing = false;
	let history = [];

	function resizeCanvas() {
		canvas.width = canvas.clientWidth;
		canvas.height = canvas.clientHeight;
	}

	function getEventCoordinates(event) {
		if (event.touches) {
			return {
				x: event.touches[0].clientX - canvas.getBoundingClientRect().left,
				y: event.touches[0].clientY - canvas.getBoundingClientRect().top
			};
		}
		return {
			x: event.offsetX,
			y: event.offsetY
		};
	}

	function startDrawing(event) {
		event.preventDefault();
		drawing = true;
		ctx.strokeStyle = selectedColor;
		ctx.beginPath();
		const { x, y } = getEventCoordinates(event);
		ctx.moveTo(x, y);
		saveState();
	}

	function draw(event) {
		event.preventDefault();
		if (!drawing) return;
		ctx.lineTo(event.offsetX, event.offsetY);
		ctx.stroke();
	}

	function stopDrawing() {
		event.preventDefault();
		drawing = false;
		ctx.closePath();
	}

	function saveState() {
		history.push(canvas.toDataURL());
	}

	function undo() {
		if (history.length > 0) {
			const lastState = history.pop();
			const img = new Image();
			img.src = lastState;
			img.onload = () => {
				ctx.clearRect(0, 0, canvas.width, canvas.height);
				ctx.drawImage(img, 0, 0);
			};
		}
	}

	async function sendImageToServer() {
		const imageData = canvas.toDataURL('image/png');
		const payload = { image: imageData, lobby_id: lobbyId };

		const response = await fetch(`${BACKEND_URL}/game_answer`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify(payload)
		});

		const data = await response.json();
		console.log('Server Response:', data);
	}

	function updateColor(event) {
		selectedColor = event.detail.color;
	}

	onMount(async () => {
		if (browser) {
			ctx = canvas.getContext('2d');
			resizeCanvas();
			ctx.lineWidth = 3;
			ctx.lineCap = 'round';

			window.addEventListener('resize', resizeCanvas);

			nickname = localStorage.getItem('nickname') || '';
			selectAvatar = localStorage.getItem('selectAvatar') || '';
			const user = {
				nickname: nickname,
				select_avatar: selectAvatar
			};
			lobbyId = $page.params.lobby;

			socket = connectWebSocket('GameChannel', lobbyId, user, (message) => {
				console.log('message: ', message);
				if (message.type === 'text') {
					if (message.data.command === 'get_players') {
						console.log('message.data.players:', message.data.players);
						players = [...message.data.players];
					} else if (message.data.command === 'set_theme') {
						console.log('set_theme: ', message.data.theme);
						theme = message.data.theme;
					} else if (message.data.command === 'answering') {
						console.log('answering');
						isAnswering = true;
					} else if (message.data.command === 'continue_game') {
						console.log('continue_game');
						isAnswering = false;
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

<section>
	<div class="mx-10 mt-10 h-60 bg-blue-800 py-10">
		<div class="mx-10 h-full bg-purple-400">
			<textarea class="mx-auto block h-full text-center text-5xl" disabled>{theme}</textarea>
		</div>
	</div>
</section>

<section class="mx-10 mt-10 bg-yellow-500 py-10">
	<div class="h-120 mx-10 flex px-10 py-10">
		<div class="canvas mr-4 h-full flex-1 bg-white">
			<canvas
				bind:this={canvas}
				on:mousedown={startDrawing}
				on:mousemove={draw}
				on:mouseup={stopDrawing}
				on:mouseleave={stopDrawing}
				class="h-full w-full border"
			>
			</canvas>
		</div>

		<div class="menu w-3/10 flex h-full flex-col bg-red-100">
			<Palette on:color={updateColor} />
			<button on:click={undo} class="mt-2 bg-blue-500 px-5 py-1 text-white hover:bg-blue-700"
				>一つ前に戻る</button
			>
			<button
				on:click={sendImageToServer}
				class="mx-auto mt-auto block h-10 w-full bg-red-500 text-white hover:bg-red-700"
				disabled={isAnswering}>発表する</button
			>
		</div>
	</div>
</section>

<style>
	canvas {
		border: 1px solid #000;
		cursor: crosshair;
		width: 100%;
		height: 100%;
		display: block;
	}

	button[disabled],
	.happyou[disabled] {
		background-color: gray;
		cursor: not-allowed;
	}
</style>
