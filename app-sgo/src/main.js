import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';

import NavigationBar from './components/NavigationBar';
import AppBar from './components/AppBar';
import ActividadesCaldera from './components/ActividadesCaldera';
import ActividadesPretratamiento from './components/ActividadesPretratamiento';
import ActividadesTorreEnfriamiento from './components/ActividadesTorreEnfriamiento';
import AgregarActividadCaldera from './components/AgregarActividadCaldera';
import Notificacion from './components/Notificacion';
import DetalleActividadCaldera from './components/DetalleActividadCaldera';
import AgregarMaterialActividad from './components/AgregarMaterialActividad';
import CambiarEstadoActividadCaldera from './components/CambiarEstadoActividadCaldera';
import EditarActividadCaldera from './components/EditarActividadCaldera';
import EditarActividadPretratamiento from "@/components/EditarActividadPretratamiento";
import TablaActividadesCaldera from './components/TablaActividadesCaldera';
import TablaActividadesPretratamiento from "@/components/TablaActividadesPretratamiento";
import TablaActividadesTorreEnfriamiento from "@/components/TablaActividadesTorreEnfriamiento";
import DetalleListadoProductosActividadCaldera from './components/DetalleListadoProductosActividadCaldera';

Vue.component('NavigationBar', NavigationBar);
Vue.component('AppBar', AppBar);
Vue.component('ActividadesCaldera', ActividadesCaldera);
Vue.component('ActividadesPretratamiento', ActividadesPretratamiento);
Vue.component('ActividadesTorreEnfriamiento', ActividadesTorreEnfriamiento);
Vue.component('AgregarActividadCaldera', AgregarActividadCaldera);
Vue.component('Notificacion', Notificacion);
Vue.component('DetalleActividadCaldera', DetalleActividadCaldera);
Vue.component('CambiarEstadoActividadCaldera', CambiarEstadoActividadCaldera);
Vue.component('AgregarMaterialActividad', AgregarMaterialActividad);
Vue.component('EditarActividadCaldera', EditarActividadCaldera);
Vue.component('EditarActividadPretratamiento', EditarActividadPretratamiento);
Vue.component('TablaActividadesCaldera', TablaActividadesCaldera);
Vue.component('TablaActividadesPretratamiento', TablaActividadesPretratamiento);
Vue.component('TablaActividadesCaldera', TablaActividadesCaldera);
Vue.component('TablaActividadesTorreEnfriamiento', TablaActividadesTorreEnfriamiento);
Vue.component('DetalleListadoProductosActividadCaldera', DetalleListadoProductosActividadCaldera);


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
