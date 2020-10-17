<template>
  <div>
    <v-app>
      <!-- Barra principal aplicación -->
      <AppBar></AppBar>
      <!-- Barra de navegación -->
      <NavigationBar></NavigationBar>
      <!-- Contenido principal -->
      <v-row>
        <v-col>
          <TablaActividadesPretratamiento></TablaActividadesPretratamiento>
        </v-col>
      </v-row>
    </v-app>
  </div>
</template>

<script>
  import axios from "axios";

  export default {
    name: "ListadoActividadesPretratamiento",
    data: () => ({
    }),
  }
</script>