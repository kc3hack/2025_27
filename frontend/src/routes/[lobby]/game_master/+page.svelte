<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import { connectWebSocket } from '$lib/chat.js';
	import { goto } from '$app/navigation';
	let zannenAudio;
	let ipponAudio;

	if (browser) {
		zannenAudio = new Audio('/zannen.wav');
		ipponAudio = new Audio('/ippon.wav');
	}

	let showBoxes = false;
	let themeBoxElement;
	let startingHeight = 0;

	function playEffect(evaluate) {
		if (!themeBoxElement) return;
		const rect = themeBoxElement.getBoundingClientRect();
		const baseHeight = rect.height;
		const baseWidth = rect.width;
		showBoxes = false;
		setTimeout(() => {
			showBoxes = true;
			startFilling(10, baseHeight, baseWidth, true); // ✅ 10個すべて表示
		}, 10);
	}

	function playRandom(evaluate) {
		if (!themeBoxElement) return;
		const rect = themeBoxElement.getBoundingClientRect();
		const baseHeight = rect.height;
		const baseWidth = rect.width;
		showBoxes = false;
		setTimeout(() => {
			showBoxes = true;
			let randomCount = Math.floor(Math.random() * 9) + 1; // ✅ 1~9個をランダム表示
			startFilling(randomCount, baseHeight, baseWidth, false);
		}, 10);
	}

	let aspectRatio = 4;
	let baseHeight = 400;

	let boxes = Array.from({ length: 10 }, (_, i) => ({
		height: baseHeight - i * (baseHeight / 10),
		width: (baseHeight - i * (baseHeight / 10)) * aspectRatio,
		color: '#ffffff'
	}));

	let visibleCount = 0;

	function startFilling(count, baseHeight, baseWidth, evaluate) {
		visibleCount = 0;
		startingHeight = baseHeight / 2 - 40;
		boxes = boxes.map((_, i) => ({
			height: baseHeight - i * (baseHeight / 10),
			width: baseWidth - i * (baseWidth / 10),
			color: '#ffffff'
		}));

		let interval = setInterval(() => {
			if (visibleCount < count) {
				// ✅ `count` の数だけ塗りつぶす
				boxes[visibleCount].color = '#faf200';
				visibleCount++;
			} else {
				clearInterval(interval);
				startIppon(evaluate);
			}
		}, 300);
	}

	function startIppon(evaluate) {
		setTimeout(() => {
			showBoxes = false;
			if (evaluate) {
				ipponAudio.play();
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
			} else {
				zannenAudio.play();
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
		}, 1000);
	}

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
		console.log('sendEvaluate: ', evaluate);
		if (evaluate) {
			playEffect(evaluate);
		} else {
			playRandom(evaluate);
		}
	}

	onMount(async () => {
		if (browser) {
			baseHeight = Math.min(window.innerHeight * 0.4);
			themeBoxElement = document.querySelector('.theme-box');
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

<section class="theme-box md:h-150 h-200">
	<div class="mx-10 mt-10 h-fit bg-blue-100 py-10">
		{#if mode === 'theme'}
			<textarea
				class="theme-box h-100 w-full bg-blue-500 text-center text-7xl"
				placeholder="お題を入力"
				bind:value={theme}
				on:input={sendTheme}
			></textarea>
		{:else}
			<div class="flex justify-center">
				<img src={img.src} class="h-100 w-full border bg-white" />
			</div>
		{/if}
		{#if showBoxes}
			<div
				class="relative flex h-full items-center justify-center"
				style="top: -{startingHeight}px"
			>
				{#each boxes as box, index}
					<div
						class="absolute border border-white transition-all duration-500"
						style="
                            width: {box.width}px;
                            height: {box.height}px;
                            background-color: {box.color};
                            border-width: 4px;
                        "
					></div>
				{/each}
			</div>
		{/if}
	</div>
</section>

<section class="mx-10 bg-blue-200 py-10">
	<div class="mx-10 bg-blue-300 px-10">
		<div class="hyouka bg-blue-600">
			<div class="flex h-40 justify-end bg-amber-200 py-3 text-black">
				<textarea
					class="heme-box mx-4 w-full text-2xl"
					placeholder="お題を入力"
					bind:value={theme}
					disabled
				></textarea>
				<button
					class="btn mr-3 w-40 rounded bg-gray-500 px-4 py-2 text-2xl text-white hover:bg-gray-700"
					on:click={() => sendEvaluate(false)}
				>
					残念!
				</button>
				<button
					class="btn mr-3 w-40 rounded bg-yellow-500 px-4 py-2 text-2xl text-white hover:bg-yellow-700"
					on:click={() => sendEvaluate(true)}
				>
					おもろい!
				</button>
			</div>
		</div>
	</div>
</section>
