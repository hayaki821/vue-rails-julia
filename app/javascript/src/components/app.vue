<template>
  <Header></Header>
  <router-view />
</template>

<script>
import { ref } from "vue";
import Header from "@/components/organisms/Header.vue";

export default {
  name: "app",
  components: {
    Header,
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>