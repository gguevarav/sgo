import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';
import DisableAutocomplete from 'vue-disable-autocomplete';

import NavigationBar from './components/NavigationBar';
import AppBar from './components/AppBar';

Vue.component('NavigationBar', NavigationBar);
Vue.component('AppBar', AppBar);
Vue.use(DisableAutocomplete);


Vue.config.productionTip = false

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!store.getters.loggedIn) {
      next({
        name: 'login',
      })
    } else {
      next()
    }
  } else {
    next() // make sure to always call next()!
  }
})

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')
