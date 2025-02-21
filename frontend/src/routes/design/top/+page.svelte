<script>
	import UserSetup from '$src/components/UserSetup.svelte';
	import HowToUse from '$src/components/HowToUse.svelte';
</script>

<main class="content h-250 container mx-auto flex items-center justify-between bg-amber-300">
	<section class="user-setup w-7/10 bg-amber-500">
		<!-- アバター、ニックネーム設定 -->
		<UserSetup />
	</section>

	<section class="how-to-use w-3/10 bg-amber-800 text-4xl">
		<!-- 遊び方説明-->
		<HowToUse />
	</section>
</main>

<style>
</style>
