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
            :to="{name: item.nombre}"
            link
            v-for="(item, index) in rutasMostrar"
            v-bind:key="index">
          <v-list-item-icon>
            <v-icon>{{ item.icono }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title> {{ item.nombreMostrar }} </v-list-item-title>
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
      rutasMostrar: this.verificarPermisos(),
    }
  },
  created () {
    bus.$on('logged', () => {
      this.isLogged = this.checkIfIsLogged();
    });
    bus.$on('menu', () => {
      this.rutasMostrar = this.verificarPermisos();
    });
  },
  methods: {
    verificarPermisos(){
      let nombreRol = localStorage.getItem('NombreRol');
      if(nombreRol === 'Administrador'){
        //this.rutasMostrar = this.rutasAdministrador;
        var rutasAdmin = [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'productos',
            icono: 'mdi-package-variant',
            nombreMostrar: 'Productos',
          },
          {
            nombre: 'inventario',
            icono: 'mdi-factory',
            nombreMostrar: 'Inventario',
          },
          {
            nombre: 'usuarios',
            icono: 'mdi-account-multiple',
            nombreMostrar: 'Usuarios',
          },
          {
            nombre: 'actividades',
            icono: 'mdi-view-dashboard',
            nombreMostrar: 'Actividades',
          },
          {
            nombre: 'listadoactividadescaldera',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Caldera',
          },
          {
            nombre: 'listadoactividadespretratamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Pretratamiento',
          },
          {
            nombre: 'listadoactividadestorreenfriamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Torre de enfriamiento',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
        ];
        return rutasAdmin;
      }
      else if(nombreRol === 'Gerente'){
        //this.rutasMostrar = this.rutasGerente;
        var rutasGerente = [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'inventario',
            icono: 'mdi-factory',
            nombreMostrar: 'Inventario',
          },
          {
            nombre: 'actividades',
            icono: 'mdi-view-dashboard',
            nombreMostrar: 'Actividades',
          },
          {
            nombre: 'listadoactividadescaldera',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Caldera',
          },
          {
            nombre: 'listadoactividadespretratamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Pretratamiento',
          },
          {
            nombre: 'listadoactividadestorreenfriamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Torre de enfriamiento',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
        ];
        return rutasGerente;
      }
      else if(nombreRol === 'Supervisor'){
        //this.rutasMostrar = this.rutasSupervisor;
        var rutasSupervisor = [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'productos',
            icono: 'mdi-package-variant',
            nombreMostrar: 'Productos',
          },
          {
            nombre: 'inventario',
            icono: 'mdi-factory',
            nombreMostrar: 'Inventario',
          },
          {
            nombre: 'actividades',
            icono: 'mdi-view-dashboard',
            nombreMostrar: 'Actividades',
          },
          {
            nombre: 'listadoactividadescaldera',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Caldera',
          },
          {
            nombre: 'listadoactividadespretratamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Pretratamiento',
          },
          {
            nombre: 'listadoactividadestorreenfriamiento',
            icono: 'mdi-format-list-bulleted',
            nombreMostrar: 'Torre de enfriamiento',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
        ];
        return rutasSupervisor;
      }
      else if(nombreRol === 'Auxiliar'){
        //this.rutasMostrar = this.rutasAuxiliar;
        var rutasAuxiliar = [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'actividades',
            icono: 'mdi-view-dashboard',
            nombreMostrar: 'Actividades',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
        ];
        return rutasAuxiliar;
      }
      else if(nombreRol === 'Operador'){
        //this.rutasMostrar = this.rutasOperador;
        var rutasOperador = [
          {
            nombre: 'home',
            icono: 'mdi-home',
            nombreMostrar: 'Inicio',
          },
          {
            nombre: 'actividades',
            icono: 'mdi-view-dashboard',
            nombreMostrar: 'Actividades',
          },
          {
            nombre: 'about',
            icono: 'mdi-help',
            nombreMostrar: 'Acerca de',
          },
        ];
        return rutasOperador;
      }
    },
    singout() {
      //localStorage.remove('access_token')
      this.isLogged = this.checkIfIsLogged()
      //this.$router.push('/logout')
    },
    checkIfIsLogged() {
      let token = localStorage.getItem('access_token');
      if (token) {
        this.NombreUsuario = localStorage.getItem('NombreUsuario');
        this.CorreoUsuario = localStorage.getItem('CorreoUsuario');
        return true;
      } else {
        return false;
      }
    },
    ocultarBarra() {
      if (this.barraNavegacion == true) {
        this.barraNavegacion = false;
        this.iconoBarra = 'mdi-plus'
      } else if (this.barraNavegacion == false) {
        this.barraNavegacion = true;
        this.iconoBarra = 'mdi-minus'
      }
    },
  },
  computed: {
    mini: {
      get() {
        return this.$vuetify.breakpoint.mdAndDown || this.overwriteBreakpoint;
      },
      set(value) {
        this.overwriteBreakpoint = value;
      }
    },
  },
}
</script>
