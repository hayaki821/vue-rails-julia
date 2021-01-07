<template>
  <div class="container">
    <form>
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li>
            <p color="red">{{ e }}</p>
          </li>
        </ul>
      </div>
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
</template>
<script>
import { ref, reactive, onMounted } from "vue";
//import { useValidation } from "vue-composable";# ダウンロード
import axios from "axios";

import juliaCanvas from "@/components/organisms/JuliaCanvas.vue";

export default {
  name: "juliaCreate",
  components: { juliaCanvas },
  setup() {
    const juliaParams = reactive({
      min_x: -1.5,
      max_x: 1.5,
      min_y: -1.5,
      max_y: 1.5,
      comp_const: { re: 0.3, im: 0.5 },
    });
    const errors = ref([]);
    const imageData = ref([]);

    const createJulia = () => {
      // validete
      //if validete return
      console.log(juliaParams);
      axios
        .post("/api/julias/create", juliaParams)
        .then((response) => {
          imageData.value = response.data.image_data;
          console.log(imageData.value);
        })
        .catch((error) => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            errors.value = error.response.data.errors;
          }
        });
    };

    return {
      juliaParams,
      imageData,
      errors,
      createJulia,
    };
  },
};
</script>