<script>
    import { onMount } from "svelte";

    export let type = "random"; // "random" または "fixed"
    export let trigger = false; // ボタンが押されたらアニメーション開始

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

    let currentIndex = 0;
    let stackedImages = [];
    let totalImages = type === "fixed" ? 10 : Math.floor(Math.random() * 10) + 1;

    $: if (trigger) {
        currentIndex = 0;
        stackedImages = [];
        totalImages = type === "fixed" ? 10 : Math.floor(Math.random() * 10) + 1;
        startAnimation();
    }

    function startAnimation() {
        const interval = setInterval(() => {
            if (currentIndex < totalImages) {
                stackedImages = [...stackedImages, images[currentIndex]];
                currentIndex++;
            } else {
                clearInterval(interval);
            }
        }, type === "fixed" ? 100 : 500); // 面白いボタンなら0.1秒、残念なら0.5秒
    }
</script>

<div class="relative w-full h-full mx-auto">
    {#each stackedImages as img, index}
        <img src={img} alt="IPPON Image" class="absolute w-full h-full object-cover" style="z-index: {index};">
    {/each}
</div>
