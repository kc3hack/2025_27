<script>
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import { page } from '$app/stores';
	import { connectWebSocket } from '$lib/chat.js';
	import { goto } from '$app/navigation';
	import UserNameSlot from '$src/components/UserNameSlot.svelte';
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

<div class="grid grid-cols-2 bg-amber-200 ">
    <div class=" bg-amber-300 flex justify-center items-center m-[5px]">      
        <div class="col-start-1 col-end-2 flex justify-center items-center flex-col m-[5px]">
            <div class="text-amber-400 flex justify-center items-center bg-gray-800 w-[200px] border border-black border-solid rounded-[40%]">
                joined members
            </div>
            <!-- 各メンバーに変数を当てて表示する メンバー追加ごとにコンポーネントを生やせると良き-->
			<!-- 今日の教訓！！！！親コンポーネントで仮置きした変数と実際に代入する変数は同じ名前にしておかないと死ぬぞ！！ -->
			{#each players as _, index}
			<UserNameSlot icon={_.image} name={_.nickname} />
			{/each}
		</div>
    </div>

    <div class="col-start-2 col-end-3 ">
		<img class="m-[5%] w-[90%]" src="https://www.fujitv.co.jp/ippon/img/logo_ogp.png" alt="IPPONグランプリ画像" >
		<dev class=" flex">
			<dev class="bg-lime-200 w-[40%] m-[5%] flex justify-center items-center sm:text-1xl md:text-2xl lg:text-3xl">
				<button on:click={inviteLink}>招待リンク発行</button>
			</dev>

			<dev class="bg-lime-200 w-[40%] m-[5%] flex justify-center items-center sm:text-1xl md:text-2xl lg:text-3xl">
				<button on:click={startGame}>ゲームスタート</button>
			</dev>
		</dev>
    </div>
</div>

<style></style>