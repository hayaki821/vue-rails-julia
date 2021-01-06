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
        <input v-model="juliaParams.min_x" type="number" />
      </div>
      <div>
        <label>実数部最大値</label>
        <input v-model="juliaParams.max_x" type="number" />
      </div>
      <div>
        <label>虚数部最小値</label>
        <input v-model="juliaParams.min_y" type="number" />
      </div>
      <div>
        <label>虚数部最大値</label>
        <input v-model="juliaParams.max_y" type="number" />
      </div>
      <div>
        <label>複素定数(実部)</label>
        <input v-model="juliaParams.comp_const.re" type="number" />
      </div>
      <div>
        <label>複素定数(虚部)</label>
        <input v-model="juliaParams.comp_const.im" type="number" />
      </div>
      <button @click.prevent="createJulia">ジュリア集合を作成する</button>
    </form>
    <juliaCanvas />
  </div>
</template>
<script>
import { ref, reactive, onMounted } from "vue";
//import { useValidation } from "vue-composable";# ダウンロード
import juliaCanvas from "@/components/organisms/JuliaCanvas.vue";

export default {
  name: "juliaCreate",
  components: { juliaCanvas },
  setup() {
    const juliaParams = reactive({
      min_x: "",
      max_x: "",
      min_y: "",
      max_y: "",
      comp_const: { re: "", im: "" },
    });
    const errors = ref([]);

    const createJulia = () => {
      // validete
      //if validete return
      console.log(juliaParams);
    };

    return {
      juliaParams,
      errors,
      createJulia,
    };
  },
};
</script>