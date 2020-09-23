<template>
  <v-app>
      <v-content>
          <v-container class="fill-height" fluid>
              <v-row align="center" justify="center">
                  <v-col cols="12" md="8" sm="8">
                      <v-card class="elevation-12">
                          <v-window v-model="step">
                              <v-window-item :value="1">
                                  <v-row>
                                      <v-col cols="12" md="12">
                                          <v-card-text class="mt-12">
                                              <h1 class="text-center display-2 primary--text text--accent-3">Sistema de gestión operativa</h1>
                                              <div class="text-center" mt-4>

                                              </div>
                                              <h4 class="text-center mlt-4">Ingresa tus credenciales</h4>
                                              <v-form>
                                                  <v-text-field
                                                  label="Correo"
                                                  name="Correo"
                                                  prepend-icon="mdi-email"
                                                  type="text"
                                                  color="dark"
                                                  />
                                                  <v-text-field
                                                  id="password"
                                                  label="Contraseña"
                                                  name="Contrasenia"
                                                  prepend-icon="mdi-lock"
                                                  type="password"
                                                  color="dark"
                                                  />
                                              </v-form>
                                          </v-card-text>
                                          <div class="text-center mt-3">
                                              <v-btn rounded color="primary">Iniciar sesión</v-btn>
                                          </div>
                                      </v-col>
                                  </v-row>
                              </v-window-item>
                          </v-window>
                      </v-card>
                  </v-col>
              </v-row>
          </v-container>
      </v-content>
  </v-app>
</template>

<script>
export default {
    data: () => ({
        step: 1
    }),
    props: {
        source: String
    }
}
</script>

<style>

</style>