<template>
  <Header></Header>
  <router-view></router-view>
</template>

<script>
import { ref } from "vue";
import Header from "@/components/organisms/header.vue";

export default {
  name: "app",
  components: {
    Header,
  },
  setup() {
    const message = ref("Hello World");

    return {
      message,
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>