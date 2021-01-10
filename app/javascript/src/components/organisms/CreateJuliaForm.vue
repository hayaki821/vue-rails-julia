<template>
  <form>
    <div v-for="(value, name) in juliaParams" :key="name">
      <template v-if="name === 'comp_const'">
        <div v-for="(c_value, c_name) in value" :key="c_name">
          <InputNumberForm
            :label="labels[c_name]"
            v-model:juliaParam="juliaParams[name][c_name]"
            @change="ChangeParam($event, name, c_name)"
          />
        </div>
      </template>
      <template v-else>
        <InputNumberForm
          v-model:juliaParam="juliaParams[name]"
          :label="labels[name]"
          @change="ChangeParam($event, name)"
        />
      </template>
    </div>
    <button
      class="fs-18 btn waves-effect waves-light"
      @click.prevent="$emit('submit')"
    >
      ジュリア集合を作成する
    </button>
  </form>
</template>

<script>
import InputNumberForm from "@/components/molecules/InputNumberForm.vue";

export default {
  name: "CreateJuliaForm",
  components: { InputNumberForm },
  props: {
    juliaParams: {
      type: Object,
      default: {},
    },
    labels: {
      type: Object,
      default: {},
      require: true,
    },
  },
  emits: ["change", "submit"],
  setup(props, context) {
    // change param
    // param (value(string), key(string), key2(string))
    const ChangeParam = (value, key, key2 = null) => {
      //if (key == "comp_const") ,key2 is not null
      context.emit("change", { value: value, key: key, key2: key2 });
    };

    return { ChangeParam };
  },
};
</script>

<style>
</style>