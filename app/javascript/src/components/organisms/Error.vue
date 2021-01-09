<template>
  <div v-if="errors.length != 0">
    <ul v-for="e in errors" :key="e">
      <li>
        <p class="co-red">
          {{ labels[Object.keys(e)[0]] }}:{{ e[Object.keys(e)[0]] }}
        </p>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    errors: {
      type: Array,
      default: [],
    },
    labels: {
      type: Object,
      default: {},
      require: true,
    },
  },
};
</script>

<style>
</style>