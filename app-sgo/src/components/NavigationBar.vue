<template>
  <v-navigation-drawer v-model="barraNavegacion" app floating :permanent="barraNavegacion" :mini-variant.sync="mini" dark>
          <v-list>
            <v-list-item>
              <v-list-item-avatar>
                <v-img src="@/assets/images/nouser.png"></v-img>
              </v-list-item-avatar>
            </v-list-item>

            <v-list-group link>
              <template v-slot:activator>
                <v-list-item-content>
                  <v-list-item-title class="title">admin</v-list-item-title>
                  <v-list-item-subtitle>admin@admin.com</v-list-item-subtitle>
                </v-list-item-content>
              </template>

              <v-list-item link>
                <v-list-item-title>Perfil de usuario</v-list-item-title>
                <v-list-item-icon>
                  <v-icon> mdi-account </v-icon>
                </v-list-item-icon>
              </v-list-item>
              <v-list-item link>
                <v-list-item-title>Cerrar sesion</v-list-item-title>
                <v-list-item-icon>
                  <v-icon> mdi-logout </v-icon>
                </v-list-item-icon>
              </v-list-item>
            </v-list-group>
          </v-list>
          <v-divider></v-divider>
          <v-list nav dense flat>
            <v-list-item-group>
              <v-list-item :to="{name: 'home'}">
                <v-list-item-icon>
                  <v-icon>mdi-home</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Inicio</v-list-item-title>
                </v-list-item-content>
              </v-list-item>

              <v-list-item :to="{name: 'productos'}">
                <v-list-item-icon>
                  <v-icon>mdi-factory</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Productos</v-list-item-title>
                </v-list-item-content>
              </v-list-item>

              <v-list-item :to="{name: 'usuarios'}">
                <v-list-item-icon>
                  <v-icon>mdi-account-multiple</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Usuarios</v-list-item-title>
                </v-list-item-content>
              </v-list-item>

              <v-list-item :to="{name: 'actividades'}">
                <v-list-item-icon>
                  <v-icon>mdi-view-dashboard</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Actividades</v-list-item-title>
                </v-list-item-content>
              </v-list-item>

              <v-list-item :to="{name: 'about'}">
                <v-list-item-icon>
                  <v-icon>mdi-help</v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title>Acerca de</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-navigation-drawer>
</template>

<script>

  import { mapState } from "vuex";

  export default {

    computed: {
      mini() {
          return (this.$vuetify.breakpoint.smAndDown) || this.toggleMini
      }
    },
    data: () => ({
      barraNavegacion: true
    }),
  };
</script>