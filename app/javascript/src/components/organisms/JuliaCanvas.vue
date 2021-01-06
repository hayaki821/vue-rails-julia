<template>
  <div>
    <canvas id="drawable" width="600" height="600"></canvas>
  </div>
</template>

<script>
import { onMounted } from "vue";
//こいつらが本来の入力
var minReal = -1.5;
var maxReal = +1.5;
var minImag = -1.5;
var maxImag = +1.5;
var cReal = 0.3;
var cImag = 0.5;
var count = 100;
function drawJuliaSet(imageData) {
  // z = Re + Im
  for (var y = 0; y < imageData.height; y++) {
    for (var x = 0; x < imageData.width; x++) {
      // 順番に座標をずらしていく作業
      var zReal = ((maxReal - minReal) / imageData.width) * x + minReal;
      var zImag = ((maxImag - minImag) / imageData.height) * y + minImag;

      setPixelColor(imageData, x, y, zReal, zImag);
    }
  }
}

function SetRGB(n, color) {
  var percent = n / count;
  switch (color) {
    case "R":
      return percent ** 0.3 * 255;
    case "G":
      return 0;
    case "B":
      return (1 - percent) ** 0.3 * 255;
    default:
      return 0;
  }
}

function setPixelColor(imageData, x, y, zReal, zImag) {
  for (var i = 0; i < count; i++) {
    if (zReal * zReal + zImag * zImag >= 4) {
      imageData.data[(y * imageData.width + x) * 4 + 0] = SetRGB(i, "R"); //R
      imageData.data[(y * imageData.width + x) * 4 + 1] = SetRGB(i, "G"); //G
      imageData.data[(y * imageData.width + x) * 4 + 2] = SetRGB(i, "B"); //B
      imageData.data[(y * imageData.width + x) * 4 + 3] = 0xff; //A
      return;
    }

    var real = zReal * zReal - zImag * zImag + cReal; // 漸化式を解いた時のRe
    var imag = 2 * zReal * zImag + cImag; // 漸化式を解いた時のIm
    zReal = real;
    zImag = imag;
  }

  // 発散しないときは０（brack）
  imageData.data[(y * imageData.width + x) * 4 + 0] = 0x00;
  imageData.data[(y * imageData.width + x) * 4 + 1] = 0x00;
  imageData.data[(y * imageData.width + x) * 4 + 2] = 0x00;
  imageData.data[(y * imageData.width + x) * 4 + 3] = 0xff;
}

export default {
  setup() {
    onMounted(() => {
      const canvas = document.getElementById("drawable");
      const context = canvas.getContext("2d");
      let imageData = context.getImageData(0, 0, canvas.width, canvas.height); //canvasエリアを指定

      drawJuliaSet(imageData);
      // ピクセルデータを描画する.
      context.putImageData(imageData, 0, 0);
    });
  },
};
</script>

<style>
</style>