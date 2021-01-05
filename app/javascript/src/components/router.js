import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/components/pages/HomePage.vue'
// import About from '@/components/pages/about.vue'
// import Contact from '@/components/pages/contact.vue'

const routerHistory = createWebHistory()

const routes = [
    { path: '/', component: Home },

  ];

  const router = createRouter({
    history: routerHistory,
    routes,
  });
  
  export default router;