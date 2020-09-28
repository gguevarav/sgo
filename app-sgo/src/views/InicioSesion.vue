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
                                      <button @click="me">Obtener usuario</button>
                                      <v-col cols="12" md="12">
                                          <v-img
                                                    src="@/assets/images/logo.png"
                                                    aspect-ratio="5"
                                                    contain
                                                    >
                                                  </v-img>
                                          <v-card-text class="mt-1">
                                              <h1 class="text-center display-2 green--text text--accent-3">SGO</h1>
                                              <v-form @submit.prevent="login">
                                                  <v-text-field
                                                  label="Correo"
                                                  name="Correo"
                                                  v-model="form.email"
                                                  prepend-icon="mdi-email"
                                                  type="text"
                                                  color="dark"
                                                  :rules="[rules.required]"
                                                  />
                                                  <v-text-field
                                                  id="password"
                                                  label="Contraseña"
                                                  name="Contrasenia"
                                                  v-model="form.password"
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
                  </v-col>
              </v-row>
          </v-container>
      </v-content>
  </v-app>
</template>


<script>
import axios from 'axios';
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000";

export default {
    name: 'InicioSesion',
    data () {
      return {
        rules: {
          required: value => !!value || 'Requerido.',
        },
        user: {},
        form: {
            email:"",
            password:""
        }
      }
    },
    methods: {
        me(){
            axios.get('/api/user').then(res => {
                console.log(res.data);
            }).catch(error => {
                console.log(error)
            })
        },
        login (){
            axios.get('/sanctum/csrf-cookie').then(() => {
                axios.post('/login', this.form).then(res =>{
                    console.log(res);
                })
            });
            //console.log(this.form);
        }
    },
}
</script>