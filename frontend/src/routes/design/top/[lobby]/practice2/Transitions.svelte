<script>
	import { fade } from 'svelte/transition';
	import { elasticOut } from 'svelte/easing';

	export let visible;

	function spin(node, { duration }) {
		return {
			duration,
			css: (t) => {
				const eased = elasticOut(t);
				return `
					transform: scale(${eased});
					color: hsl(
						${~~(t * 360)},
						${Math.min(100, 1000 - 1000 * t)}%,
						${Math.min(50, 500 - 500 * t)}%
					);`;
			}
		};
	}
</script>

{#if visible}
	<div class="centered text-9xl place-items-center" in:spin={{ duration: 8000 }} out:fade>
		<span>wara-1!</span>
	</div>
{/if}
