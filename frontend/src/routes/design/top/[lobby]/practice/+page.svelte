<script>  
    import Canvas from '$src/components/Canvas.svelte'
	import Palette from '$src/components/Palette.svelte'

    const colors = [
		'#d58141',
		'#d7c44c',
		'#4fa9cc',
		'#3f8d27',
	]
	const background = '#fff'

	let color = colors[0]
	const paletteColor = color
</script>

<section>
    <div class="bg-blue-800 mx-10 mt-10 py-10 h-60">
        <div class="bg-purple-400 h-full mx-10"></div>
    </div>
</section>

<section class="bg-yellow-500 mx-10 mt-10 py-10">
    <div class="bg-red-500 h-120 mx-10 py-10 px-10 flex">
        <div class="canvas w-7/10 bg-red-400 h-full mr-4">
            <Canvas />
        </div>

        <div class="menu w-3/10 bg-red-100 h-full flex flex-col">
            <Palette />
            <div class="happyou h-10 w-full bg-purple-700 mt-auto flex" ></div>
        </div>
    </div>
</section>