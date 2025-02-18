<script>
    let name ="";
</script>

<div class="container">
    <header class="header">
        <h1>WARA1</h1>
    </header>

    <main class="main">
        <!-- アバター、ニックネーム設定 -->
        <section class="user-setup">
            <p class="setup-text">アバターとニックネームを設定してください</p>
            <input type="text" bind:value={name} placeholder="名前を入力"/>
            <button class="start-button">スタート</button>
        </section>

        <!-- 遊び方書く -->
        <section class="how-to-use">
            <h2>遊び方</h2>
            <p>ここに説明書く</p>
        </section>  
    </main>

    <footer class="footer">
        <p>WARA1</p>
    </footer>
</div>

<style>
    html, body {
        width: 100vw;
        height: 100vh;
        margin: 0;
        padding: 0;
        overflow: hidden;
        display: flex;
        flex-direction:column;
        align-items: center;
    }
    .container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
        width: 100vw;
    }
    .header {
        width: 100%;
        text-align: center;
        font-size: 4vw;
        font-weight: bold;
        padding: 1vh 0;
    }

    .main {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-grow: 1;
        width: 150%;
        height: 60vh;
        background-color: #a3892e;
        padding: 2vw;
        border-radius: 10px;
    }

    .user-setup {
        width: 70%;
        text-align: center;
    }

    .setup-text {

    }

    .how-to-use {
        width: 30%;
        text-align: center;
    }

    .footer {
        margin-top: 20px;
        font-weight: bold;
    }
</style>