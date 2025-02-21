<script>
// @ts-nocheck

    export let name;
    export let setName;
</script>

<section class="col-6 user-setup text-4xl w-7/10 bg-amber-500">
    <p class="setup-text">アバターとニックネームを設定してください</p>
    <input type="text" bind:value={name} placeholder="名前を入力" />
    <!-- スタートボタン -->
    <button class="px-6 bg-white text-lg rounded-md hover:bg-gray-200">
        スタート
    </button>
</section>