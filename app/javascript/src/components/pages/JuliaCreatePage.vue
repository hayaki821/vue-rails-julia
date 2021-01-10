<template>
  <div class="container mt-2">
    <p>有効数字は17桁です。</p>
    <Error :errors="errors" :labels="labels" />
    <CreateJuliaForm
      :juliaParams="juliaParams"
      :labels="labels"
      @change="changeJuliaParam"
      @submit="createJulia"
    />
    <juliaCanvas :imageData="imageData" />
  </div>
  <Loading :loading="loading" />
</template>
<script>
import { ref, reactive, onMounted } from "vue";
import axios from "axios";

import juliaCanvas from "@/components/organisms/JuliaCanvas.vue";
import CreateJuliaForm from "@/components/organisms/CreateJuliaForm.vue";
import Loading from "@/components/organisms/Loading.vue";
import Error from "@/components/organisms/Error.vue";

export default {
  name: "juliaCreate",
  components: { juliaCanvas, CreateJuliaForm, Loading, Error },
  setup() {
    // label name
    const labels = {
      min_x: "実数部最小値",
      max_x: "実数部最大値",
      min_y: "虚数部最小値",
      max_y: "虚数部最大値",
      re: "複素定数(実部)",
      im: "複素定数(虚部)",
    };
    let juliaParams = reactive({
      // defalut
      min_x: -1.5,
      max_x: 1.5,
      min_y: -1.5,
      max_y: 1.5,
      comp_const: { re: 0.3, im: 0.5 },
    });
    const errors = ref([]);
    const imageData = ref([]); // julia pixel data
    const loading = ref(false);

    const createJulia = () => {
      // to do validete
      //if validete return

      // api start
      loading.value = true;
      axios
        .post("/api/julias/create", juliaParams)
        .then((response) => {
          imageData.value = response.data.image_data;
          errors.value = []; //error reset
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors; // get error messages
          }
        })
        .finally(() => {
          loading.value = false;
        });
    };

    const changeJuliaParam = (param) => {
      const value = param.value; // change value
      const key = param.key;
      const key2 = param.key2; //null or key2
      // if comp_const change
      if (key2 != null) {
        juliaParams[key][key2] = Number(value);
        return;
      }
      // if key2 == null
      console.log(juliaParams);
      juliaParams[key] = Number(value);
    };

    return {
      labels,
      juliaParams,
      imageData,
      errors,
      loading,
      changeJuliaParam,
      createJulia,
    };
  },
};
</script>
<style scoped>
</style>