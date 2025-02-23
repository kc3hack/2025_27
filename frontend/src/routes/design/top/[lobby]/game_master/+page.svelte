<script>  
    import { onMount } from "svelte";

    let showBoxes = false;

    function playEffect() {
        showBoxes = false;
        setTimeout(() => {
            showBoxes = true;
            startFilling(10); // ✅ 10個すべて表示
        }, 10);
    }

    function playRandom() {
        showBoxes = false;
        setTimeout(() => {
            showBoxes = true;
            let randomCount = Math.floor(Math.random() * 9) + 1; // ✅ 1~9個をランダム表示
            startFilling(randomCount);
        }, 10);
    }

    let aspectRatio = 4; 
    let baseHeight = Math.min(window.innerHeight * 0.4); // ✅ 画面高さの50%、最大400px

    let boxes = Array.from({ length: 10 }, (_, i) => ({
        height: baseHeight - i * (baseHeight / 10), // ✅ 画面の高さに応じた縦幅
        width: (baseHeight - i * (baseHeight / 10)) * aspectRatio, // ✅ 横幅 = 縦幅 × 4
        color: "#ffffff",
    }));

    let visibleCount = 0;

    function startFilling(count) { // ✅ `count` を引数として受け取る
        visibleCount = 0;
        boxes = boxes.map(box => ({ ...box, color: "#ffffff" }));

        let interval = setInterval(() => {
            if (visibleCount < count) { // ✅ `count` の数だけ塗りつぶす
                boxes[visibleCount].color = "#faf200"; 
                visibleCount++;
            } else {
                clearInterval(interval);
            }
        }, 300);
    }
</script>

<section>
    <div class="bg-blue-100 mx-10 mt-10 py-10 h-100">
        <div class="bg-blue-400 h-full mx-10 text-7xl">
            私たちの解答
            {#if showBoxes}
            <div class="flex justify-center items-center h-full ">
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
    </div>
</section>

<section class="bg-blue-200 mx-10 mt-10 py-10">
    <div class="bg-blue-300 h-100 mx-10 py-10 px-10 ">
        <div class="user-display h-7/10 bg-blue-500 flex"> 
            <div class="user1 w-1/3 h-full mx-3 bg-amber-500"></div>
            <div class="user2 w-1/3 h-full bg-amber-800"></div>
            <div class="user3 w-1/3 h-full mx-3 bg-amber-500"></div>
        </div>

        <div class="hyouka h-3/10 bg-blue-600 ">
            <div class= "bg-amber-200 py-3 mx-3 text-white flex justify-end">
                <button on:click={playRandom} class="px-10 py-3 bg-yellow-600 mx-1 text-white text-2xl hover:bg-orange-200">
                    残念！
                </button>
                <button on:click={playEffect} class="px-10 py-3 bg-yellow-600 text-white text-2xl hover:bg-orange-200">
                    面白い！
                </button>
            </div>
        </div>
    </div>
</section>
