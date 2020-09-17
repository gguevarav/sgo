import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    barraNavegacion: true
  },
  mutations: {
    cambiarEstadoBarra(state) {
      state.barraNavegacion = !state.barraNavegacion
    }
  },
  actions: {},
  modules: {}
})