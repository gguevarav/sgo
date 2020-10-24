<template>
  <div>
    <v-app-bar
        color="secondary"
        dense
        dark
        app
        v-if="isLogged">
      <v-app-bar-nav-icon
          @click="ocultarBarra()">
        <v-icon>
          {{ iconoBarra }}
        </v-icon>
      </v-app-bar-nav-icon>
      <v-toolbar-title>Sistema de gestión operativa</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn
          text
          :to="{name: 'logout'}"
          @click.prevent="singout">
        <v-icon>
          mdi-power</v-icon>
      </v-btn>
    </v-app-bar>
    <v-navigation-drawer
        color="primary"
        v-model="barraNavegacion"
        app
        floating
        :permanent="barraNavegacion"
        :mini-variant.sync="mini"
        dark
        v-if="isLogged">
      <v-list>
        <v-list-item class="px-2">
          <v-list-item-avatar>
            <v-img src="@/assets/images/nouser.png"></v-img>
          </v-list-item-avatar>
        </v-list-item>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="title">{{ NombreUsuario }}</v-list-item-title>
            <v-list-item-subtitle>{{ CorreoUsuario }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
      <v-divider></v-divider>
      <v-list
          nav
          dense
      >
        <v-list-item
            :to="{name: 'home'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Inicio</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'productos'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-package-variant</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Productos</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'inventario'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-factory</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Inventario</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'usuarios'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-account-multiple</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Usuarios</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'actividades'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-view-dashboard</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Actividades</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'listadoactividadescaldera'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-format-list-bulleted</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Caldera</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'listadoactividadespretratamiento'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-format-list-bulleted</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Pretraramiento</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'listadoactividadestorreenfriamiento'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-format-list-bulleted</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Torre de enfriamiento</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item
            :to="{name: 'about'}"
            link>
          <v-list-item-icon>
            <v-icon>mdi-help</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Acerca de</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>

import { bus } from '../main';

export default {
  data () {
    return {
      barraNavegacion: true,
      iconoBarra: 'mdi-minus',
      NombreUsuario: localStorage.getItem('NombreUsuario'),
      CorreoUsuario: localStorage.getItem('CorreoUsuario'),
      isLogged: this.checkIfIsLogged(),
    }
  },
  created () {
    bus.$on('logged', () => {
      this.isLogged = this.checkIfIsLogged()
    })
  },
  methods: {
    singout() {
      //localStorage.remove('access_token')
      this.isLogged = this.checkIfIsLogged()
      //this.$router.push('/logout')
    },
    checkIfIsLogged() {
      let token = localStorage.getItem('access_token')
      if (token) {
        this.NombreUsuario = localStorage.getItem('NombreUsuario');
        this.CorreoUsuario = localStorage.getItem('CorreoUsuario');
        return true
      } else {
        return false
      }
    },
    ocultarBarra(){
      if(this.barraNavegacion == true){
        this.barraNavegacion = false;
        this.iconoBarra = 'mdi-plus'
      }else if(this.barraNavegacion == false){
        this.barraNavegacion = true;
        this.iconoBarra = 'mdi-minus'
      }
    },
  },
  computed: {
    mini() {
      return (this.$vuetify.breakpoint.smAndDown) || this.toggleMini
    },
  },
}
</script>
