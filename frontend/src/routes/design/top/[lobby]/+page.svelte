
<script>
	
    import { goto } from '$app/navigation';

    function navigate() {
        goto('/ogiri'); // /ogiri へ移動
    }
</script>

<div class="lobby">
    <div class="title">
        <div class="intitle">
            WARA-1
        </div>
    </div> 

    <div class="memberSide">      
        <dev class="memberList">
            <dev class="member">
                <dev class="icon">
                    icon(予)
                </dev>
                <dev class="memName">
                    粗品A
                </dev>
            </dev>
            <dev class="member">
                <dev class="icon">
                    icon(予)
                </dev>
                <dev class="memName">
                    粗品B
                </dev>
            </dev>
            <dev class="member">
                <dev class="icon">
                    icon(予)
                </dev>
                <dev class="memName">
                    粗品C
                </dev>
            </dev>
            <dev class="member">
                <dev class="icon">
                    icon(予)
                </dev>
                <dev class="memName">
                    粗品D
                </dev>
            </dev>
            <dev class="member">
                <dev class="icon">
                    icon(予)
                </dev>
                <dev class="memName">
                    バカリズム
                </dev>
            </dev>
        </dev>
    </div>

    <dev class="start">
        <img src="https://www.fujitv.co.jp/ippon/img/logo_ogp.png" alt="IPPONグランプリ画像" width="90%">
        <dev class="touch">
            <dev class="item">
                招待
            </dev>

            <dev class="item">
                <button on:click={navigate}>スタート</button>
            </dev>
        </dev>
    </dev>
</div>

<style>
    .lobby{
        display: grid;
        grid-template-areas: 
        "title title"
        "memberList start";
        background-color: rgba(174, 174, 20, 0.71);
        grid-template-columns: 5fr 5fr;
        grid-template-rows: 1fr 4fr;
        height: 100vh;
    }

    .lobby .title{
        grid-area: title;
        display: flex;
        justify-content: center; /* 横軸中央 */
        align-items: center; /* 縦軸中央 */
        background-color: rgba(132, 132, 15, 0.71);
        font-size: 10vh;
    }

    .lobby .title .intitle{
        display: grid;
        place-items: center; /* 二つ合わせて縦横中央 */
        background-color: rgba(174, 174, 20, 0.71);
        padding: 0px 20px;
    }

    .lobby .memberSide{
        background-color: rgba(176, 127, 23, 0.71);
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 5%;
    }

    .lobby .memberSide .memberList{
        grid-area: memberList;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .lobby .memberSide .memberList .member{
        grid-template-areas:
        "icon memName";
        grid-template-columns: 5.9vh auto;
        background-color: rgba(132, 132, 15, 0.71);
        width: 100%;
        margin: 0.9vh;
    }

    .lobby .memberSide .memberList .member .icon{
        grid-area: icon;
    }

    .lobby .memberSide .memberList .member .memName{
        grid-area: memName;
        font-size: 5vh;
    }

    .lobby .start{
        grid-area: start;
        display: grid;
        grid-template-rows: 6fr 1fr 1fr 2fr;
        
    }

    .lobby .start .touch{
        grid-row-start: 3;
        grid-row-end: 4;
        display: flex;
    }

    .lobby .start .touch .item{

        background-color: rgb(206, 246, 161);
        width: 40%;
        margin-left: 5%;
        margin-right: 5%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 3vh;
    }

    img{
        margin: 5%;
        
    }
</style>