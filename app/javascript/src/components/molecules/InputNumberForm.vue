<template>
  <label>{{ label }}</label>
  <input
    v-model.number="juliaParam"
    @change="$emit('change', $event.target.value)"
    type="number"
    step="0.1"
  />
</template>

<script>
export default {
  name: "inputForm",
  props: {
    juliaParam: {
      type: Number,
      default: 0,
    },
    label: {
      type: String,
      default: "",
      require: true,
    },
  },
  emits: ["change"],
};
</script>

<style>
</style>