<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';

	export let color = '#333';
	export let background = '#fff';

	let canvas;
	let ctx;
	let drawing = false;
	let context;
	let isDrawing;
	let start;

	function resizeCanvas() {
		canvas.width = canvas.clientWidth;
		canvas.height = canvas.clientHeight;
	}

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

	onMount(() => {
		if (browser) {
			ctx = canvas.getContext('2d');
			ctx.lineWidth = 3;
			ctx.lineCap = 'round';
			window.addEventListener('resize', resizeCanvas);
		}

		// handleSize();
		// saveState();
	});

	// $: if (ctx) {
	// 	ctx.strokeStyle = color;
	// }

	let t, l;
	let history = []; //Undo用
	// const handleStart = ({ offsetX: x, offsetY: y }) => {
	// 	saveState(); //これを描かなかったら機能しない
	// 	if (color === background) {
	// 		ctx.clearRect(0, 0, width, height);
	// 	} else {
	// 		isDrawing = true;
	// 		start = { x, y };
	// 	}
	// };

	// const handleEnd = () => {
	// 	isDrawing = false;
	// };

	// const handleMove = ({ offsetX: x1, offsetY: y1 }) => {
	// 	if (!isDrawing) return;

	// 	const { x, y } = start;
	// 	context.beginPath();
	// 	context.moveTo(x, y);
	// 	context.lineTo(x1, y1);
	// 	context.closePath();
	// 	context.stroke();

	// 	start = { x: x1, y: y1 };
	// };

	// const handleSize = () => {
	// 	const { top, left } = canvas.getBoundingClientRect();
	// 	t = top;
	// 	l = left;
	// };

	// const saveState = () => {
	// 	history.push(canvas.toDataURL());
	// };

	//Undo機能
	// const undo = () => {
	// 	if (history.length > 1) {
	// 		history.pop(); //最新の履歴を削除
	// 		const lastState = history[history.length - 1]; //一つ前の履歴を取得
	// 		restoreCanvas(lastState);
	// 	}
	// };

	// **キャンバスを復元**
	// const restoreCanvas = (imageData) => {
	// 	const img = new Image();
	// 	img.src = imageData;
	// 	img.onload = () => {
	// 		context.clearRect(0, 0, canvas.width, canvas.height);
	// 		context.drawImage(img, 0, 0);
	// 	};
	// };
</script>

<canvas
	bind:this={canvas}
	on:mousedown={startDrawing}
	on:mousemove={draw}
	on:mouseup={stopDrawing}
	on:mouseleave={stopDrawing}
	class="h-full w-full border"
>
</canvas>

<style>
	canvas {
		border: 1px solid #000;
		cursor: crosshair;
		width: 100%;
		height: 100%;
		display: block;
	}
</style>
