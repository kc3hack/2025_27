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
<main class="content h-250 container mx-auto flex flex-col items-center justify-between bg-amber-300">
    <!-- お題表示の部分 -->
    <section class= "w-full bg-yellow-500 p-10 text-5xl rounded-md text-center text-black">
        お題:ボウリングで全ての投球がガターだった時、起こることは？
    </section>

    <!-- お絵描き部分 -->
    <section class="p-6 rounded-md flex mt-6 items-center">
        <div class="Drawing section">
            <h3>お絵描き</h3>
            <Canvas {color} {background} />
            <Palette 
                {paletteColor}
                {colors}
                {background}
                on:color="{({ detail }) => {
                    color = detail.color;
                }}"
            />
        </div>
    </section>
</main>


