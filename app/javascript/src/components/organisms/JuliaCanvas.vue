<template>
  <div class="canvas">
    <canvas id="drawable" width="600" height="600"></canvas>
  </div>
</template>

<script>
import { watch, onMounted, watchEffect } from "vue";

function setImageData(imageData, newVal) {
  for (var i = 0; i < imageData.data.length; i++) {
    imageData.data[i] = newVal[i];
  }
}

export default {
  props: {
    imageData: {
      type: Array,
    },
  },
  setup(props) {
    // const canvas = document.getElementById("drawable");
    // const context = canvas.getContext("2d");
    onMounted(() => {
      watchEffect(() => {
        const canvas = document.getElementById("drawable");
        const context = canvas.getContext("2d");
        let imageData = context.getImageData(0, 0, canvas.width, canvas.height); //canvasエリアを指定
        setImageData(imageData, props.imageData);
        context.putImageData(imageData, 0, 0);
      });
    });
  },
};
</script>

<style>
.canvas {
  margin-top: 2em;
  text-align: center;
}
</style>