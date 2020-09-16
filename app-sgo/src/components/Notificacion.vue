<template>
    <!-- Snackbar de notificaciones -->
        <v-snackbar
        v-model="snackbar"
        :timeout="timeout"
        color="success">

        {{ textoSnackbar }}

        <template
            v-slot:action="{ attrs }">
            <v-btn
            color="blue darken-1"
            text
            v-bind="attrs"
            @click="snackbar = false">
            Close
            </v-btn>
        </template>
        </v-snackbar>
    <!-- Termina Snackbar de notificaciones -->
</template>

<script>
export default {
    data: () => ({
      snackbar: false,
      textoSnackbar: '',
      timeout: 3000
    }),
}
</script>

<style>

</style>