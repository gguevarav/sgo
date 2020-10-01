import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import NotFound from '../views/NotFound'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Actividades from '../views/Actividades.vue'
import Productos from '../views/Productos.vue'
import Usuarios from '../views/Usuarios.vue'
import About from '../views/About.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/home',
    name: 'home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  linkActiveClass: 'is-active',
  routes: [
    {
      path: '/home',
      name: 'home',
      component: Home,
        meta: {
            requiresAuth: true,
        }
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
    },
      {
          path: '/',
          redirect: '/home'
      },
    {
        path: '/logout',
        name: 'logout',
        component: Logout,
        meta: {
            requiresAuth: true,
        }
    },
    { 
        path: '/404', 
        name: '404', 
        component: NotFound,
    },
    { 
        path: '*', 
        redirect: '/404', 
    },
      {
          path: '/about',
          name: 'about',
          component: About,
          meta: {
              requiresAuth: true,
          }
      },
    {
      path: '/actividades',
      name: 'actividades',
      component: Actividades,
        meta: {
            requiresAuth: true,
        }
    },
    {
      path: '/productos',
      name: 'productos',
      component: Productos,
        meta: {
            requiresAuth: true,
        }
    },
    {
      path: '/usuarios',
      name: 'usuarios',
      component: Usuarios,
        meta: {
            requiresAuth: true,
        }
    },
  ]
})

export default router
