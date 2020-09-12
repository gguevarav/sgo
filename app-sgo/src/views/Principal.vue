<template>
  <div>
    <v-app>
        <!-- Barra principal aplicación -->
        <!-- <AppBar></AppBar> -->
        <!-- Barra de navegación -->
        <!-- <NavigationBar></NavigationBar> -->
        <!-- Contenido principal -->
        <v-content>
          <v-container>
            <router-view></router-view>
          </v-container>
        </v-content>
    </v-app>
  </div>
</template>

<script>

  import NavigationBar from './components/NavigationBar';
  import AppBar from './components/AppBar';

  export default {
    name: 'Principal',

    components: {
      NavigationBar,
      AppBar
    },

    data: () => ({
      
    }),
  };
</script>
