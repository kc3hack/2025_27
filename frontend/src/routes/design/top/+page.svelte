<script>
	let name = '';
</script>

<main class="content h-250 container mx-auto bg-amber-300">
	<!-- アバター、ニックネーム設定 -->
	<section class="col-6 user-setup bg-amber-500">
		<p class="setup-text">アバターとニックネームを設定してください</p>
		<input type="text" bind:value={name} placeholder="名前を入力" />
		<button class="start-button">スタート</button>
	</section>
	<section class="col-6 how-to-use bg-amber-800">
		<!-- 遊び方書く -->
		<h2>遊び方</h2>
		<p>ここに説明書く</p>
	</section>
</main>

<style>
	.content {
	}

	.user-setup {
	}

	.setup-text {
	}

	.how-to-use {
	}
</style>
