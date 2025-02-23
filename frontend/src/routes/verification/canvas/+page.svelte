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
		const { x, y } = getEventCoordinates(event);
		ctx.lineTo(x, y);
		ctx.stroke();
	}

	function stopDrawing(event) {
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
			document.body.addEventListener('touchstart', (e) => e.preventDefault(), { passive: false });
			document.body.addEventListener('touchmove', (e) => e.preventDefault(), { passive: false });

			nickname = localStorage.getItem('nickname') || '';
			selectAvatar = localStorage.getItem('selectAvatar') || '';
			const user = {
				nickname: nickname,
				select_avatar: selectAvatar
			};
			lobbyId = $page.params.lobby;

			socket = connectWebSocket('GameChannel', lobbyId, user, (message) => {
				console.log('message: ', message);
			});
		}
	});
</script>

<canvas
	bind:this={canvas}
	on:mousedown={startDrawing}
	on:mousemove={draw}
	on:mouseup={stopDrawing}
	on:mouseleave={stopDrawing}
	on:touchstart={startDrawing}
	on:touchmove={draw}
	on:touchend={stopDrawing}
	class="h-full w-full border"
></canvas>

<style>
	canvas {
		border: 1px solid #000;
		cursor: crosshair;
		width: 100%;
		height: 100%;
		display: block;
		touch-action: none;
	}
</style>
