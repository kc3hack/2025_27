<div class="lobby">
    <div class="title">
        <div class="intitle">
            WARA-1
        </div>
    </div> 

    <dev class="memberList">
        <dev class="member">
            粗品A
        </dev>
        <dev class="member">
            粗品B
        </dev>
        <dev class="member">
            粗品C
        </dev>
        <dev class="member">
            粗品D
        </dev>
        <dev class="member">
            粗品E
        </dev>
    </dev>

    <dev class="start">
        ここにタイトルとスタートボタン。それに招待ボタンを配置する
    </dev>
</div>

<style>
    .lobby{
        display: grid;
        grid-template-areas: 
        "title title"
        "memberList start";
        background-color: rgba(174, 174, 20, 0.71);
        grid-template-columns: 3fr 2fr;
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

    .lobby .memberList{
        grid-area: memberList;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .lobby .memberList .member{
        background-color: rgba(132, 132, 15, 0.71);
        margin: 20px;
    }
    
    .lobby .start{
        grid-area: start;

    }
</style>