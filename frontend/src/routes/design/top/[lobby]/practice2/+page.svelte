<script>
    import { onMount } from "svelte";

    // 画像のパスを配列に格納
    const images = [
        "/images/IPPONG01.png",
        "/images/IPPONG02.png",
        "/images/IPPONG03.png",
        "/images/IPPONG04.png",
        "/images/IPPONG05.png",
        "/images/IPPONG06.png",
        "/images/IPPONG07.png",
        "/images/IPPONG08.png",
        "/images/IPPONG09.png",
        "/images/IPPONG10.png",
    ];

    let currentIndex = 0; // 現在表示している画像の数
    let stackedImages = []; // 表示する画像を格納する配列

    onMount(() => {
        const interval = setInterval(() => {
            if (currentIndex < images.length) {
                stackedImages = [...stackedImages, images[currentIndex]]; // 画像を追加
                currentIndex++;
            } else {
                clearInterval(interval); // 10枚すべて表示されたらストップ
            }
        }, 100)
    });
</script>

<!-- 画像表示エリア -->
<div class="relative w-200 h-150 mx-auto">
    {#each stackedImages as img, index}
        <img src={img} alt="Stacked Image" class="absolute w-full h-full object-cover" style="z-index: {index};">
    {/each}
</div>

<style>
</style>
