<template>
  <div class="container mt-2">
    <p>有効数字は17桁です。</p>
    <Error :errors="errors" :labels="labels" />
    <form>
      <div>
        <label>実数部最小値</label>
        <input v-model.number="juliaParams.min_x" type="number" step="0.1" />
      </div>
      <div>
        <label>実数部最大値</label>
        <input v-model.number="juliaParams.max_x" type="number" step="0.1" />
      </div>
      <div>
        <label>虚数部最小値</label>
        <input v-model.number="juliaParams.min_y" type="number" step="0.1" />
      </div>
      <div>
        <label>虚数部最大値</label>
        <input v-model.number="juliaParams.max_y" type="number" step="0.1" />
      </div>
      <div>
        <label>複素定数(実部)</label>
        <input
          v-model.number="juliaParams.comp_const.re"
          type="number"
          step="0.1"
        />
      </div>
      <div>
        <label>複素定数(虚部)</label>
        <input
          v-model.number="juliaParams.comp_const.im"
          type="number"
          step="0.1"
        />
      </div>
      <button @click.prevent="createJulia">ジュリア集合を作成する</button>
    </form>
    <juliaCanvas :imageData="imageData" />
  </div>
  <Loading :loading="loading" />
</template>
<script>
import { ref, reactive, onMounted } from "vue";
//import { useValidation } from "vue-composable";# ダウンロード
import axios from "axios";

import juliaCanvas from "@/components/organisms/JuliaCanvas.vue";
import Loading from "@/components/organisms/Loading.vue";
import Error from "@/components/organisms/Error.vue";
export default {
  name: "juliaCreate",
  components: { juliaCanvas, Loading, Error },
  setup() {
    // params name
    const labels = {
      min_x: "実数部最小値",
      max_x: "実数部最大値",
      min_y: "虚数部最小値",
      max_y: "虚数部最大値",
      re: "複素定数(実部)",
      im: "複素定数(虚部)",
    };
    const juliaParams = reactive({
      min_x: -1.5,
      max_x: 1.5,
      min_y: -1.5,
      max_y: 1.5,
      comp_const: { re: 0.3, im: 0.5 },
    });
    const errors = ref([]);
    const imageData = ref([]);
    const loading = ref(false);

    const createJulia = () => {
      // validete
      //if validete return
      loading.value = true;
      axios
        .post("/api/julias/create", juliaParams)
        .then((response) => {
          imageData.value = response.data.image_data;
          errors.value = [];
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors;
          }
        })
        .finally(() => {
          loading.value = false;
        });
    };

    return {
      labels,
      juliaParams,
      imageData,
      errors,
      loading,
      createJulia,
    };
  },
};
</script>
<style scoped>
</style>