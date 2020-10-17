<template>
  <v-app>
      <v-content>
          <v-container class="fill-height" fluid>
              <v-row align="center" justify="center">
                  <v-col cols="12" md="8" sm="8">
                      <v-card class="elevation-12">
                          <v-window>
                              <v-window-item :value="1">
                                  <v-row>
                                      <v-col cols="12" md="12">
                                          <v-img
                                                    src="@/assets/images/logo.png"
                                                    aspect-ratio="5"
                                                    contain
                                                    >
                                                  </v-img>
                                          <v-card-text class="mt-1">
                                              <h1 class="text-center display-2 green--text text--darken-3">SGO</h1>
                                              <v-form @submit.prevent="login">
                                                  <v-text-field
                                                  label="Correo"
                                                  name="Correo"
                                                  v-model="form.CorreoUsuario"
                                                  prepend-icon="mdi-email"
                                                  type="text"
                                                  color="dark"
                                                  :rules="[rules.required]"
                                                  />
                                                  <v-text-field
                                                  id="password"
                                                  label="Contraseña"
                                                  name="Contrasenia"
                                                  v-model="form.ContraseniaUsuario"
                                                  prepend-icon="mdi-lock"
                                                  type="password"
                                                  color="dark"
                                                  :rules="[rules.required]"
                                                  />
                                              </v-form>
                                          </v-card-text>
                                          <div class="text-center mt-3">
                                              <v-btn rounded color="primary" @click="login">Iniciar sesión</v-btn>
                                          </div>
                                      </v-col>
                                  </v-row>
                              </v-window-item>
                          </v-window>
                      </v-card>
                    <!-- Notificación -->
                    <Notificacion
                        :activar="activarNotificacion"
                        :textoSnackbar="textoMostrarNotificacion"
                        :color="colorNotificacion"
                        @cerrarNotificacion="cerrarNotificacion">
                    </Notificacion>
                    <!-- Notificación -->
                  </v-col>
              </v-row>
          </v-container>
      </v-content>
  </v-app>
</template>

<script>
import axios from "axios";

export default {
  name: 'login',
  data () {
    return {
      rules: {
        required: value => !!value || 'Requerido.',
      },
      user: {},
      form: {
        CorreoUsuario:"",
        ContraseniaUsuario:""
      },
      error: null,
      activarNotificacion: false,
      textoMostrarNotificacion: '',
      colorNotificacion: '',
    }
  },
  methods: {
    login() {
      this.$store
          .dispatch("retrieveToken", {
            username: this.form.CorreoUsuario,
            password: this.form.ContraseniaUsuario
          })
          .then(response => {
            this.$router.push({ name: "home" });
            this.almacenarDatosUsuario();
          })
          .catch(error => {
            this.error = error.response.data;
            this.activarNotificacion = true;
            this.textoMostrarNotificacion = "Correo o contraseña inválido";
            this.colorNotificacion  = 'red';
          });
    },

    almacenarDatosUsuario(){
      return new Promise((resolve, reject) => {
        // Almacenamos la info del usuario
        axios.get('/api/auth/user',  {
          headers: { Authorization: localStorage.getItem('access_token') }
        })
            .then(response => {
              //console.log(response);
              localStorage.setItem('idUsuario', response.data.idUsuario);
              localStorage.setItem('NombreUsuario', response.data.NombreUsuario + ' ' + response.data.ApellidoUsuario);
              localStorage.setItem('CorreoUsuario', response.data.email);
              resolve(response)
            })
            .catch(error => {
              console.log(error)
              console.log("error")
              reject(error)
            })
      });
    },

    cerrarNotificacion(cerrarNotificacion){
      this.activarNotificacion = cerrarNotificacion
      this.activarNotificacion = false;
    },
  }
};
</script>