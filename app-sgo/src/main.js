import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';
// Barra de Navegación
import BarraNavegacion from './components/NavigationBar';
// Componente pricipal para agregar materiales
import AgregarMaterialActividad from './components/Material/AgregarMaterialActividad';
// Componenetes para exportar datos de actidades
import ExportarAExcel from './components/Exportar/ExportarAExcel';
import ExportarActividades from './components/Exportar/ExportarActividades';
// Actividades caldera
import ActividadesCaldera from './components/ActividadesCaldera/ActividadesCaldera';
import AgregarActividadCaldera from './components/ActividadesCaldera/AgregarActividadCaldera';
import DetalleActividadCaldera from './components/ActividadesCaldera/DetalleActividadCaldera';
import DetalleListadoProductosActividadCaldera from './components/ActividadesCaldera/DetalleListadoProductosActividadCaldera';
import CambiarEstadoActividadCaldera from './components/ActividadesCaldera/CambiarEstadoActividadCaldera';
import EditarActividadCaldera from './components/ActividadesCaldera/EditarActividadCaldera';
import TablaActividadesCaldera from './components/ActividadesCaldera/TablaActividadesCaldera';

///////////////////////////////////////////////////////////////////////

// Actividades Pretratamiento
import ActividadesPretratamiento from './components/ActividadesPretratamiento/ActividadesPretratamiento';
import AgregarActividadPretratamiento from './components/ActividadesPretratamiento/AgregarActividadPretratamiento';
import DetalleActividadPretratamiento from './components/ActividadesPretratamiento/DetalleActividadPretratamiento';
import DetalleListadoProductosActividadPretratamiento from './components/ActividadesPretratamiento/DetalleListadoProductosActividadPretratamiento';
import CambiarEstadoActividadPretratamiento from './components/ActividadesPretratamiento/CambiarEstadoActividadPretratamiento';
import EditarActividadPretratamiento from "@/components/ActividadesPretratamiento/EditarActividadPretratamiento";
import TablaActividadesPretratamiento from "@/components/ActividadesPretratamiento/TablaActividadesPretratamiento";

///////////////////////////////////////////////////////////////////////

// Actividades torre enfriamiento
import ActividadesTorreEnfriamiento from './components/ActividadesTorreEnfriamiento/ActividadesTorreEnfriamiento';
import AgregarActividadTorreEnfriamiento from './components/ActividadesTorreEnfriamiento/AgregarActividadTorreEnfriamiento';
import DetalleActividadTorreEnfriamiento from "@/components/ActividadesTorreEnfriamiento/DetalleActividadTorreEnfriamiento";
import DetalleListadoProductosActividadTorreEnfriamiento from "@/components/ActividadesTorreEnfriamiento/DetalleListadoProductosActividadTorreEnfriamiento";
import CambiarEstadoActividadTorreEnfriamiento from "@/components/ActividadesTorreEnfriamiento/CambiarEstadoActividadTorreEnfriamiento";
import TablaActividadesTorreEnfriamiento from "@/components/ActividadesTorreEnfriamiento/TablaActividadesTorreEnfriamiento";

// Nombres componentes
// Barra de navegación
Vue.component('BarraNavegacion', BarraNavegacion);
// Componente principal para agregar materiales
Vue.component('AgregarMaterialActividad', AgregarMaterialActividad);
// Componente para exportar datos
Vue.component('ExportarAExcel', ExportarAExcel);
Vue.component('ExportarActividades', ExportarActividades);
// Importe de componenetes de actividades de caldera
Vue.component('ActividadesCaldera', ActividadesCaldera);
Vue.component('AgregarActividadCaldera', AgregarActividadCaldera);
Vue.component('DetalleActividadCaldera', DetalleActividadCaldera);
Vue.component('DetalleListadoProductosActividadCaldera', DetalleListadoProductosActividadCaldera);
Vue.component('CambiarEstadoActividadCaldera', CambiarEstadoActividadCaldera);
Vue.component('EditarActividadCaldera', EditarActividadCaldera);
Vue.component('TablaActividadesCaldera', TablaActividadesCaldera);

// Importe de actividades de Pretratamiento
Vue.component('ActividadesPretratamiento', ActividadesPretratamiento);
Vue.component('AgregarActividadPretratamiento', AgregarActividadPretratamiento);
Vue.component('DetalleActividadPretratamiento', DetalleActividadPretratamiento);
Vue.component('DetalleListadoProductosActividadPretratamiento', DetalleListadoProductosActividadPretratamiento);
Vue.component('CambiarEstadoActividadPretratamiento', CambiarEstadoActividadPretratamiento);
Vue.component('EditarActividadPretratamiento', EditarActividadPretratamiento);
Vue.component('TablaActividadesPretratamiento', TablaActividadesPretratamiento);

// Importe de actividades de Torre de enfriamiento
Vue.component('ActividadesTorreEnfriamiento', ActividadesTorreEnfriamiento);
Vue.component('AgregarActividadTorreEnfriamiento', AgregarActividadTorreEnfriamiento);
Vue.component('DetalleActividadTorreEnfriamiento', DetalleActividadTorreEnfriamiento);
Vue.component('DetalleListadoProductosActividadTorreEnfriamiento', DetalleListadoProductosActividadTorreEnfriamiento);
Vue.component('CambiarEstadoActividadTorreEnfriamiento', CambiarEstadoActividadTorreEnfriamiento);
Vue.component('TablaActividadesTorreEnfriamiento', TablaActividadesTorreEnfriamiento);


Vue.config.productionTip = false

export const bus = new Vue();

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
