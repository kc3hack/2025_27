<script>
	import UserNameSlot from '$src/components/UserNameSlot.svelte';

	let name = 'バカリズム';
	let icon = 'https://i.pinimg.com/736x/bf/fa/67/bffa675de717844c2b0a9f2bc42a5c04.jpg';
	/* 多分関数とかで人数分取ってこれば良き */
</script>

<div class="grid grid-cols-2 bg-amber-200">
	<div class=" m-[5px] flex items-center justify-center bg-amber-300">
		<dev class="col-start-1 col-end-2 m-[5px] flex flex-col items-center justify-center">
			<div
				class="flex w-[200px] items-center justify-center rounded-[40%] border border-solid border-black bg-gray-800 text-amber-400"
			>
				joined members
			</div>
			<!-- 各メンバーに変数を当てて表示する メンバー追加ごとにコンポーネントを生やせると良き-->
			<UserNameSlot {icon} {name} />
			<UserNameSlot {icon} {name} />
			<UserNameSlot {icon} {name} />
			<UserNameSlot {icon} {name} />
			<UserNameSlot {icon} {name} />
		</dev>
	</div>

	<dev class="col-start-2 col-end-3"> </dev>
</div>

<style></style>
