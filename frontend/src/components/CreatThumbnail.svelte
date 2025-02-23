<script>
    export const metadata = {
      title: "Page Title",
      description: "logoWARA1",
      image: "/images/logoWARA1.png",  // 動的にサムネイル画像を指定
    };
  </script>
  
  <svelte:head>
    <meta property="og:image" content={metadata.image}>
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:image:type" content="image/png">
  </svelte:head>
  