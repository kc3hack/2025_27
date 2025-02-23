<script>  
</script>

<section>
    <!-- 背景画像 -->
    <div class="mx-10 mt-10 py-10 h-130 flex items-center bg-center opacity-30 bg-no-repeat">
    </div>
</section>

<section class="bg-blue-200 mx-10 py-10 overflow-hidden">
    <div class="bg-blue-300 h-80 mx-10 py-10 px-10 text-7xl relative">
        エンドロール

        <div class="marquee-container">
            <div class="marquee-content">
                <!-- 画像 -->
                <img src="/images/dmm.png" class="h-30 w-auto mx-5">
                <img src="/images/tgl.png" class="h-30 w-auto mx-5">
                <img src="/images/sakura.png" class="h-30 w-auto mx-5">
                <img src="/images/smartHR.png" class="h-30 w-auto mx-5">
                <img src="/images/stores.png" class="h-30 w-auto mx-5">
                <img src="/images/yumemi.png" class="h-30 w-auto mx-5">
                <img src="/images/engineerGuild.png" class="h-30 w-auto mx-5">
                <img src="/images/Dimps.png" class="h-30 w-auto mx-5">
                <img src="/images/job.png" class="h-30 w-auto mx-5">

                <!-- テキスト -->
                <p class="text-white text-5xl font-bold mx-5 text-nowrap inline-block">yamaguchi</p>
                <p class="text-white text-5xl font-bold mx-5 text-nowrap inline-block">takami</p>
                <p class="text-white text-5xl font-bold mx-5 text-nowrap inline-block">takaoka</p>

            </div>
        </div>
    </div>
</section>

<style>
    .marquee-container {
        overflow: hidden;
        white-space: nowrap;
        display: flex;
        align-items: center;
        width: 100%;
        position: relative;
    }

    .marquee-content {
        display: flex;
        align-items: center;
        animation: marquee 20s linear infinite;
    }

    @keyframes marquee {
        from {
            transform: translateX(100%);
        }
        to {
            transform: translateX(-100%);
        }
    }

    .text-nowrap {
        white-space: nowrap;
    }
</style>
