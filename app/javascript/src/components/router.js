import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/components/pages/HomePage.vue'
import JuliaCreate from '@/components/pages/JuliaCreatePage.vue'
// import Contact from '@/components/pages/contact.vue'

const routerHistory = createWebHistory()

const routes = [
    { path: '/', component: Home },
    { path: '/satori/julia', component: JuliaCreate}
  ];

  const router = createRouter({
    history: routerHistory,
    routes,
  });
  
  export default router;