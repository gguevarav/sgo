<template>
  <!-- Snackbar de notificaciones -->
  <v-snackbar
    v-model="activar"
    :timeout="timeout"
    :color="color">

    {{ textoSnackbar }}

    <template
        v-slot:action="{ attrs }">
        <v-btn
        color="blue darken-1"
        text
        v-bind="attrs"
        @click="cerrarNotificacion">
        Close
        </v-btn>
    </template>
  </v-snackbar>
  <!-- Termina Snackbar de notificaciones -->
</template>

<script>
export default {
  name: 'Notificacion',
    data: function () {
      return {
        //snackbar: this.activar,
        //textMostrar: this.textoSnackbar,
        timeout: 3000,
      }
    },
  props: ['activar',
          'textoSnackbar',
          'color'],
  methods: {
    cerrarNotificacion() {
      let cerrarNofificacion = !this.activar;
      this.$emit("cerrarNotificacion", cerrarNofificacion);
    }
  }
}
</script>

<style>

</style>