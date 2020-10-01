import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

//axios.defaults.withCredentials = true;
axios.defaults.baseURL ="http://localhost:8000"

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: localStorage.getItem('access_token') || null,
    datos: null,
    NombreUsuario: null,
    CorreoUsuario: null,
  },
  getters:{
    loggedIn(state){
      return state.token !== null
    }
  },
  mutations: {
    retrieveToken(state, token){
      state.token = token
    },
    destroyToken (state){
      state.token = null
    },
    obtenerInformacionUsuario(state, datos){
      state.datos = datos
    },
    almacenarInfoUsuario(state, infoUsuario){

    }
  },
  actions: {
    retrieveToken(context, credentials) {

      return new Promise((resolve, reject) => {
        axios.post('/api/auth/login', {
          email: credentials.username,
          password: credentials.password,
        })
          .then(response => {
            //console.log(response)
            const token = response.data.access_token
            localStorage.setItem('access_token', 'Bearer ' + token)
            context.commit('retrieveToken', token)
            resolve(response)
          })
          .catch(error => {
            //console.log(error)
            reject(error)
          })
      });

    },

    obtenerInformacionUsuario(context, datos){

      return new Promise((resolve, reject) => {
        // Almacenamos la info del usuario
        axios.get('/api/auth/user', '', {
          headers: { Authorization: context.state.token }
        })
            .then(response => {
              console.log("Prueba")
              //datos = response
              localStorage.setItem('prueba', 'funciona')
              //context.commit(response.data)

              resolve(response)
            })
            .catch(error => {
              console.log(error)
              console.log("error")
              reject(error)
            })
      });
    },

    destroyToken(context) {
      
      if (context.getters.loggedIn){
        
        return new Promise((resolve, reject) => {
          axios.post('/api/auth/logout', '', {
              headers: { Authorization: context.state.token }
            })
            .then(response => {
              //console.log(response)
              localStorage.removeItem('access_token')
              context.commit('destroyToken')
  
              resolve(response)
            })
            .catch(error => {
              //console.log(error)
              localStorage.removeItem('access_token')
              context.commit('destroyToken')

              reject(error)
            })
        })
      }
    }
  },
  modules: {
  }
})
