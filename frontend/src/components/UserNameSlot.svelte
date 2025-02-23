<script>
    export let icon ='';
    export let name ='';
</script>

<dev class="bg-yellow-200 grid grid-cols-7 gap-0 border-solid border-2 m-[5px]">
    <div class="flex justify-center items-center">
        <img src={icon} alt="icon画像" width="70px">
    </div>
    <dev class="flex items-center sm:text-3xl md:text-4xl lg:text-5xl col-start-2 col-end-8">
        {name}
    </dev>
</dev>