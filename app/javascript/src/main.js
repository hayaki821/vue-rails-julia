import { createApp } from 'vue'
import App from '@/components/app.vue'
import router from '@/components/router.js'

export default () => {
    document.addEventListener('DOMContentLoaded', () => {
        const app = createApp(App)
        app.use(router)
        app.mount('#vue-app')
    })
}