<script>
    export let slides; // スライドデータ
    export let currentSlide; // 現在のスライドインデックス
    export let setCurrentSlide; // スライドを変更する関数
</script>

<h2>遊び方</h2>
<!-- 説明文 -->
<div class="bg-amber-700 p-4 rounded-md flex flex-col items-center">
    <!-- スライド画像 -->
    <div class="h-48 rounded-md">
        <img 
            src={slides[currentSlide].img} 
            alt="Slide Image" 
            class="w-full h-full object-cover"
        />
    </div>

    <p class="text-lg text-white text-center mb-4">
        {slides[currentSlide].text}
    </p>

    <!-- スライド -->
    <div class="flex justify-center items-center space-x-2 mt-4">
        {#each slides as _, index}
            <div 
                class="cursor-pointer transition-colors duration-300 text-lg font-bold"
                class:text-white={currentSlide !== index}
                class:text-yellow-400={currentSlide === index}
                on:click={() => setCurrentSlide(index)}
            >
                {currentSlide === index ? "◎" : "●"}
            </div>
        {/each}
    </div>
</div>

