<template>
    <v-app-bar color="primary" dense dark app>

        <v-app-bar-nav-icon @click="false"></v-app-bar-nav-icon>

        <v-toolbar-title>Sistema de gestión operativa</v-toolbar-title>

        <v-spacer></v-spacer>

        <v-btn text :to="{name: 'logout'}">
            <v-icon>
                mdi-power</v-icon>
        </v-btn>

    </v-app-bar>
</template>

<script>
    import { mapMutations } from "vuex";

    export default {
        name: 'AppBar',
        data: () => ({
            //barraNavegacion: true
        }),
        
    }
</script>

<style>

</style>