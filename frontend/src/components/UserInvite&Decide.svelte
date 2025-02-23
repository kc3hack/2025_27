<script>
    import { goto } from '$app/navigation';

    function navigate() {
        goto('/design/top/lobby/ogiri'); // /ogiri へ移動
    }
</script>
      
<img class="m-[5%] w-[90%]" src="https://www.fujitv.co.jp/ippon/img/logo_ogp.png" alt="IPPONグランプリ画像" >
<dev class=" flex">
    <dev class="bg-lime-200 w-[40%] m-[5%] flex justify-center items-center sm:text-1xl md:text-2xl lg:text-3xl">
        招待
    </dev>

    <dev class="bg-lime-200 w-[40%] m-[5%] flex justify-center items-center sm:text-1xl md:text-2xl lg:text-3xl">
        <button on:click={navigate}> メンバー決定</button>
    </dev>
</dev>