<script>  
    import Canvas from './Canvas.svelte'
	import Palette from './Palette.svelte'

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
<main class="content h-250 container mx-auto flex flex-col bg-amber-300">
    <!-- お題表示の部分 -->
    <section class= "w-full bg-yellow-500 p-15 text-5xl rounded-md text-center text-black">
        お題:ボウリングで全ての投球がガターだった時、起こることは？
    </section>

    
    <!-- お絵描き部分 -->
        <div class="Drawing section w-1/2 bg-amber-600">
            <Canvas {color} {background} />
            <div class="palette w-1/2 bg-amber-500">
            <Palette 
                {paletteColor}
                {colors}
                {background}
                on:color="{({ detail }) => {
                    color = detail.color;
                }}"
            />
            </div>
        </div>

    <!-- 発表部分 -->
    <div class= "bg-amber-200 p-5 flex justify-end fixed bottom-20 right-1">
        <button class="px-10 py-3 bg-yellow-600 text-white rounded-md text-4xl hover:bg-orange-200">
            発表する！
        </button>
    </div>
    

</main>


