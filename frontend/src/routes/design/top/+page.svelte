<script>
    let name ="";
</script>

<header class="header">
    <h1>WARA1</h1>
</header>

<main class="main">
    <!-- アバター、ニックネーム設定 -->
    <section class="user-setup">
        <p>アバターとニックネームを設定してください</p>
        <input type="text" bind:value={name} placeholder="名前を入力"/>
        <button class="start-button">スタート</button>
    </section>

    <!-- 遊び方書く -->
    <section class="how-to-use">
        <h2>遊び方</h2>
        <p>説明書く</p>
    </section>  
</main>

<footer class="footer">
    <p>WARA1</p>
</footer>

<style>
    body {
        display: flex;
        flex-direction:column;
        align-items: center;
        justify-content: center;
        height: 100vh;
        padding: 20px;
    }
    .header {
        color: #000000;
        text-align: center;
        font-weight: bold;
    }

    .main {
        display: flex;
        justify-content: space-between; 
        background-color: #a3892e;
        padding: 20px;
        border-radius: 10px;
    }

    .user-setup {
        width: 70%;
        text-align: center;
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