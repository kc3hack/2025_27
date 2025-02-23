<script>
	import { onMount } from 'svelte'
	
	export let width = 1000
	export let height = 650
	export let color = '#333'
	export let background = '#fff'
	
	let canvas
	let context
	let isDrawing
	let start
	
	let t, l
	let history = [] //Undo用
	onMount(() => {
		context = canvas.getContext('2d')
		context.lineWidth = 3
		
		handleSize()
		saveState() 
	})
	
	$: if(context) {
			context.strokeStyle = color
	}
	
	const handleStart = (({ offsetX: x, offsetY: y }) => {
		saveState() //これを描かなかったら機能しない 
		if(color === background) {
			context.clearRect(0, 0, width, height)
		} else {
			isDrawing = true
			start = { x, y }
		}
	})
	
	const handleEnd = () => { isDrawing = false }
	const handleMove = (({ offsetX: x1, offsetY: y1 }) => {
		if(!isDrawing) return
		
		const { x, y } = start
		context.beginPath()
		context.moveTo(x, y)
		context.lineTo(x1, y1)
		context.closePath()
		context.stroke()
		
		start = { x: x1, y: y1 }
	})
	
	const handleSize = () => {
		const { top, left } = canvas.getBoundingClientRect()
		t = top
		l = left
	}
	//履歴を保存
	const saveState = () => {
		history.push(canvas.toDataURL())
	}

	//Undo機能
	const undo = () => {
		if (history.length > 1) {
			history.pop() //最新の履歴を削除
			const lastState = history[history.length - 1] //一つ前の履歴を取得
			restoreCanvas(lastState)
		}
	}

	// **キャンバスを復元**
	const restoreCanvas = (imageData) => {
		const img = new Image()
		img.src = imageData
		img.onload = () => {
			context.clearRect(0, 0, canvas.width, canvas.height)
			context.drawImage(img, 0, 0)
		}
	}
</script>

<svelte:window on:resize={handleSize} />
<canvas
	class="w-full h-full"
	style:background
	bind:this={canvas} 
	on:mousedown={handleStart}	
	on:touchstart={e => {
		const { clientX, clientY } = e.touches[0]
		handleStart({
			offsetX: clientX - l,
			offsetY: clientY - t
		})
	}}	
	on:mouseup={handleEnd}				
	on:touchend={handleEnd}				
	on:mouseleave={handleEnd}
	on:mousemove={handleMove}
	on:touchmove={e => {
		const { clientX, clientY } = e.touches[0]
		handleMove({
			offsetX: clientX - l,
			offsetY: clientY - t
		})
	}}
	>
</canvas> 