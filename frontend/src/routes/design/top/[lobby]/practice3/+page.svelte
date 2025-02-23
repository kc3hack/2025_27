<script>
    import { onMount } from "svelte";

    let aspectRatio = 4; // ✅ 縦:横 = 1:4 の比率（横 = 縦 × 4）

    let boxes = Array.from({ length: 10 }, (_, i) => ({
        height: 400 - i * 30, // ✅ 縦幅を基準
        width: (400 - i * 30) * aspectRatio, // ✅ 横幅 = 縦幅 × 4
        color: "#ffffff", // ✅ 最初は白色
    }));

    let visibleCount = 0; // 表示される四角の数

    // 0.5秒ごとに1つずつ塗りつぶす
    onMount(() => {
        let interval = setInterval(() => {
            if (visibleCount < boxes.length) {
                boxes[visibleCount].color = "#faf200"; // ✅ 青色に変更
                visibleCount++;
            } else {
                clearInterval(interval); // すべて表示されたら停止
            }
        }, 300);
    });
</script>

<!-- 四角を順番に塗りつぶす -->
<div class="relative flex justify-center items-center h-screen">
    {#each boxes as box, index}
        <div
            class="absolute border border-white transition-all duration-500"
            style="
                width: {box.width}px;
                height: {box.height}px;
                background-color: {box.color};
                border-width: 2px;
            "
        ></div>
    {/each}
</div>
