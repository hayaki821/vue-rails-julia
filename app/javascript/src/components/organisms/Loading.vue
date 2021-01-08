<template>
  <div v-if="loading" class="load-layer">
    <div class="load-containr">
      <p class="c-white fs-18">ジュリア集合を作成中です</p>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    loading: {
      type: Boolean,
      require: true,
    },
  },
};
</script>
<style scoped>
.c-white {
  color: white;
}
.load-containr {
  display: flex;
  height: 50%;
  justify-content: center;
  align-items: center;
}

.load-layer {
  position: absolute;
  top: 0px;
  left: 0px;

  width: 100%;
  height: 200%;

  background-color: #000000;
  opacity: 0.5;
  z-index: 100;
}
</style>