<script>
	let name = '';

    let currentStep = 0;

	const steps = [
		"ここに説明01",
		"ここに説明02",
		"ここに説明03",
		"ここに説明04",
		"ここに説明05",
		"ここに説明06"
	];

	function nextStep() {
		currentStep = (currentStep + 1) % steps.length;
	}
</script>

<main class="content h-250 container mx-auto bg-amber-300 flex justify-between">
	<!-- アバター、ニックネーム設定 -->
	<section class="col-6 user-setup text-4xl w-7/10 bg-amber-500">
		<p class="setup-text">アバターとニックネームを設定してください</p>
		<input type="text" bind:value={name} placeholder="名前を入力" />
		<!-- スタートボタン -->
        <button 
        on:click={() => console.log("")}
        class="px-6 bg-white text-lg rounded-md hover:bg-gray-200"
        >
        スタート
        </button>
	</section>

	<section class="col-6 how-to-use text-4xl w-3/10 bg-amber-800">
		<!-- 遊び方書く -->
		<h2>遊び方</h2>
		<p>ここに説明書く</p>
        <div class="bg-amber-700 p-4 rounded-md flex flex-col items-center">    
            <!-- 説明文 -->
            <p class="text-lg text-white text-center mb-4">
                {steps[currentStep]}
            </p>

            <!-- 次へボタン -->
            <button 
                on:click={nextStep} 
                class="px-6 bg-white text-lg rounded-md hover:bg-gray-200"
            >
                次へ
            </button>
        </div>
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
