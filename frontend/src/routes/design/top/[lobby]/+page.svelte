<script>
	import UserInviteDecide from '$src/components/UserInvite&Decide.svelte';
	import UserNameSlot from '$src/components/UserNameSlot.svelte';
    
    let name ='バカリズム';
    let icon ='https://i.pinimg.com/736x/bf/fa/67/bffa675de717844c2b0a9f2bc42a5c04.jpg';
    /* 多分関数とかで人数分取ってこれば良き */
</script>

<div class="grid grid-cols-2 bg-amber-200 ">
    <div class=" bg-amber-300 flex justify-center items-center m-[5px]">      
        <dev class="col-start-1 col-end-2 flex justify-center items-center flex-col m-[5px]">
            <div class="text-amber-400 flex justify-center items-center bg-gray-800 w-[200px] border border-black border-solid rounded-[40%]">
                joined members
            </div>
            <!-- 各メンバーに変数を当てて表示する メンバー追加ごとにコンポーネントを生やせると良き-->
            <UserNameSlot {icon} {name} />
            <UserNameSlot {icon} {name} />
            <UserNameSlot {icon} {name} />
            <UserNameSlot {icon} {name} />
            <UserNameSlot {icon} {name} />
        </dev>
    </div>

    <dev class="col-start-2 col-end-3 ">
        <UserInviteDecide />
    </dev>
</div>

<style></style>