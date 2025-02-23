<script>
	import UserSetup from '$src/components/UserSetup.svelte';
	import HowToUse from '$src/components/HowToUse.svelte';
	import Header from '$src/components/Header.svelte';
	import CreatThumbnail from '$src/components/CreatThumbnail.svelte'
</script>

<Header />
<main class="content container mx-auto flex h-screen items-center justify-between bg-amber-300">
	<section class="user-setup w-7/10 bg-amber-500">
		<UserSetup />
	</section>

	<section class="how-to-use w-3/10 bg-amber-800 text-4xl">
		<HowToUse />
	</section>
</main>

<style>
</style>
