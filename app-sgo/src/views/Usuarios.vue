<template>
  <div class="text-center">
    <!-- Snackbar de notificaciones -->
    
    <!-- Termina Snackbar de notificaciones -->

    <!-- Tabla de usuarios -->
    <v-data-table
      :headers="headers"
      :items="datosTabla"
      :items-per-page="5"
      sort-by="NombreUsuario"
      class="elevation-1">
      <template v-slot:top>
        <v-toolbar
          flat
          color="white">
          <v-toolbar-title>
            Usuarios
          </v-toolbar-title>
          <v-spacer></v-spacer>

          <!-- Dialog de botones de agregar y recargar -->
          <v-dialog v-model="dialog" max-width="500px">
            <template
                v-slot:activator="{ on, attrs }">
                  <v-btn
                    text
                    class="mb-2"
                    v-bind="attrs"
                    v-on="on"
                    @click="!dialog">
                      <v-icon>
                        mdi-plus
                      </v-icon>
                </v-btn>
                <v-btn
                  text
                  class="mb-2"
                  @click="initialize">
                    <v-icon>
                      mdi-reload
                    </v-icon>
                </v-btn>
              </template>
          </v-dialog>
          <!-- Termina dialog de botones de agregar y recargar -->

          <!-- Cuadro de edición de usuario -->
          <v-dialog
            v-model="dialog"
            max-width="500px">
            <v-card>
              <v-card-title>
                <span
                  class="headline">
                  {{ formTitle }}
                </span>
              </v-card-title>
              <v-card-text>
                <v-form>
                  <v-alert
                    type="error"
                    v-model="alertaErrores">
                    Los registros contienen los siguientes errores:
                    <li
                      v-for="value in listadoErrores"
                      v-bind:key>
                      {{ value }}
                    </li>
                  </v-alert>
                  <v-container>
                    <v-row>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                            v-model="editedItem.NombreUsuario"
                            label="Nombre"
                            :rules="[rules.required]">
                          </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                          v-model="editedItem.ApellidoUsuario"
                          label="Apellido"
                          :rules="[rules.required]">
                        </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-text-field
                            v-model="editedItem.CorreoUsuario"
                            :disabled="editarCorreo"
                            label="Correo"
                            :rules="[rules.required, rules.email]">
                          </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                        <v-text-field
                          v-model="editedItem.ContraseniaUsuario"
                          :append-icon="verContrasenia ? 'mdi-eye' : 'mdi-eye-off'"
                          :rules="[rules.required, rules.min]"
                          :type="verContrasenia ? 'text' : 'password'"
                          name="input-10-1"
                          label="Contraseña"
                          hint="At least 8 caracteres"
                          counter
                          @click:append="verContrasenia = !verContrasenia">
                        </v-text-field>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="12"
                        md="12">
                        <v-btn-toggle
                          v-model="toggle_exclusive"
                          group
                          multiple>
                          <v-select
                            :items="datosPuestos"
                            item-text='NombrePuesto'
                            item-value='idPuesto'
                            v-model="editedItem.idPuesto"
                            label="Puesto"
                            :rules="[rules.required]">
                          </v-select>
                          <v-btn
                            text
                            @click="dialogPuestos = !dialogPuestos">
                              <v-icon>
                                mdi-plus
                              </v-icon>
                          </v-btn>
                        </v-btn-toggle>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                        <v-select
                          :items="datosRoles"
                          item-text='NombreRol'
                          item-value='idRol'
                          v-model="editedItem.idRol"
                          label="Rol"
                          :rules="[rules.required]">
                        </v-select>
                      </v-col>
                      <v-col
                        cols="12"
                        sm="6"
                        md="6">
                          <v-select
                            :items="datosEstadoUsuario"
                            item-text='NombreEstadoUsuario'
                            item-value='idEstadoUsuario'
                            v-model="editedItem.EstadoUsuario"
                            :disabled="estadoHabilitado"
                            label="Estado"
                            :rules="[rules.required]">
                          </v-select>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  text @click="cerrarDialogRegistro">
                    Cancelar
                </v-btn>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="guardarInformacion">
                    Guardar
                  </v-btn>
              </v-card-actions>
            </v-card>
            <!-- Termina cuadro de edición de usuario -->
          </v-dialog>

          <!-- Cuadro de registro de nuevo puesto -->
          <v-dialog
            v-model="dialogPuestos"
            max-width="500px">
            <v-card>
              <v-card-title>
                <span
                  class="headline">
                    Nuevo puesto
                </span>
              </v-card-title>

              <v-card-text>
                <v-alert
                    type="error"
                    v-model="alertaErroresPuesto">
                    Los registros contienen los siguientes errores:
                    <li
                      v-for="value in listadoErroresPuesto"
                      v-bind:key>
                      {{ value }}
                    </li>
                </v-alert>
                <v-form>
                  <v-container>
                    <v-row
                      align="center"
                      justify="center">
                      <v-col
                        cols="12">
                        <v-text-field
                          ref="NombrePuesto"
                          v-model="nuevoPuesto.NombrePuesto"
                          label="Nombre"
                          :rules="[rules.required]"
                          required>
                        </v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="cerrarDialogPuesto">
                    Cancelar
                </v-btn>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="guardarPuesto">
                    Guardar
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <!-- Termina cuadro de registro de nuevo puesto -->
        </v-toolbar>
      </template>
      <template
        v-slot:item.actions="{ item }">
          <v-icon
            small
            class="mr-2"
            @click="editarUsuario(item, item.idUsuario)">
              mdi-pencil
          </v-icon>
          <v-icon
            small
            disabled
            @click="eliminarUsuario(item.idUsuario)">
              mdi-delete
          </v-icon>
      </template>
    </v-data-table>
    <!-- Termina tabla de usuarios -->
  </div>
</template>

<script>
  import axios from "axios";
  axios.defaults.withCredentials = true;
  axios.defaults.baseURL ="http://localhost:8000"

  export default {
    name: 'Usuarios',
    components:{
      
    },
    data: () => ({
      verContrasenia: false,
      toggle_exclusive: undefined,
      dialog: false,
      dialogPuestos: false,
      alertaErrores: false,
      alertaErroresPuesto: false,
      headers: [{
          text: 'idUsuario',
          align: 'start',
          sortable: false,
          value: 'idUsuario',
        },
        {
          text: 'Nombre',
          value: 'NombreUsuario'
        },
        {
          text: 'Apellido',
          value: 'ApellidoUsuario'
        },
        {
          text: 'Correo',
          value: 'CorreoUsuario'
        },
        {
          text: 'Puesto',
          value: 'NombrePuesto'
        },
        {
          text: 'Rol',
          value: 'NombreRol'
        },
        {
          text: 'Estado',
          value: 'NombreEstado'
        },
        {
          text: 'Actions',
          value: 'actions',
          sortable: false
        },
      ],
      rules: {
        required: value => !!value || 'Campo requerido.',
        min: v => v.length >= 8 || '8 caracteres como mínimo',
        counter: value => value.length <= 20 || 'Max 20 characters',
        email: value => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
          return pattern.test(value) || 'Correo inválido'
        },
      },
      listadoErrores: [],
      listadoErroresPuesto: [],
      datosTabla: [],
      select: [],
      datosPuestos: [],
      datosRoles: [],
      datosEstadoUsuario: [{
          idEstadoUsuario: 1,
          NombreEstadoUsuario: 'Activo'
        },
        {
          idEstadoUsuario: 2,
          NombreEstadoUsuario: 'Inactivo'
        }
      ],
      editedIndex: -1,
      idUsuarioEditar: 0,
      editarCorreo: false,
      estadoHabilitado: true,
      editedItem: {
        NombreUsuario: '',
        ApellidoUsuario: '',
        CorreoUsuario: '',
        idPuesto: '',
        ContraseniaUsuario: '',
        idRol: '',
        EstadoUsuario: 1,
      },
      defaultItem: {
        NombreUsuario: '',
        ApellidoUsuario: '',
        CorreoUsuario: '',
        idPuesto: '',
        ContraseniaUsuario: '',
        idRol: '',
        EstadoUsuario: 1,
      },
      nuevoPuesto: {
        NombrePuesto: '',
        EstadoPuesto: 1,
      },
      defaultnuevoPuesto: {
        NombrePuesto: '',
        EstadoPuesto: 1,
      },
    }),

    computed: {
      formTitle() {
        return this.editedIndex === -1 ? 'Nuevo usuario' : 'Editar usuario'
      },
      form() {
        return {
          NombrePuesto: this.NombrePuesto,
        }
      }
    },

    watch: {
      dialog(val) {
        val || this.cerrarDialogPuesto()
      },
    },

    created() {
      this.initialize()
    },

    methods: {
      initialize() {

        //axios.get("/sanctum/csrf-cookie").then(() => {
          axios
            .get("/usuarios")
            .then(response => {
              if (response.data.total != 0) {
                this.datosTabla = response.data.detalle
              }
            })
            .catch(function (error) {
              console.log(error);
            });
        //});
        axios
          .get("/puestos")
          .then(response => {
            if (response.data.total != 0) {
              this.datosPuestos = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
        axios
          .get("/roles")
          .then(response => {
            if (response.data.total != 0) {
              this.datosRoles = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
      },

      editarUsuario(item, idUsuario) {
        this.idUsuarioEditar = idUsuario
        this.editedIndex = this.datosTabla.indexOf(item)
        this.editedItem = Object.assign({}, item)
        if (this.editedIndex > -1) {
          this.editarCorreo = true
          this.estadoHabilitado = false
        } else {
          this.editarCorreo = false
          this.estadoHabilitado = true
        }
        this.dialog = true
      },

      eliminarUsuario(id) {
        confirm('¿Está seguro que desea eliminar este usuario?') && axios
          .delete("/usuarios/" + id)
          .then(function (response) {
            //console.log(response);
          })
          .catch(function (error) {
            console.log(error);
          })
      },

      guardarInformacion() {
        // Si el valor del índice de edición es mayor al que se está editando entonces 
        if (this.editedIndex > -1) {
          //axios.get("/sanctum/csrf-cookie").then(() => {
            axios
            .put("/usuarios/" + this.idUsuarioEditar,
              this.editedItem)
            .then(response => {
              //console.log(response);
              // Cerramos el cuadro de diálogo y mostraremos una notificación
              this.textoSnackbar = 'Usuario editado exitosamente'
              this.snackbar = !this.snackbar
              this.cerrarDialogPuesto()
            })
            .catch(function (error) {
              console.log(error);
            })
          //});
        } else {
          axios
            .post("/usuarios",
              this.editedItem)
            .then(response => {
              if (response.data.status == 200) {
                //console.log("exito")
                // Mostramos la confirmación
                this.textoSnackbar = 'Usuario agregado exitosamente'
                this.snackbar = !this.snackbar
                this.cerrarDialogPuesto()
              } else if (response.data.status == 404) {
                //console.log("error")
                this.listadoErrores = response.data.errores
                this.alertaErrores = true
              }
            })
            .catch(function (error) {
              console.log(error);
            })
        }
        this.initialize()
      },

      guardarPuesto() {

        axios
          .post("/puestos",
            this.nuevoPuesto)
          .then(response => {
              if (response.data.status == 200) {
                //console.log("exito")
                // Mostramos la confirmación
                this.textoSnackbar = 'Puesto agregado exitosamente'
                this.snackbar = !this.snackbar
                this.cerrarDialogPuesto()
              } else if (response.data.status == 404) {
                //console.log("error")
                this.listadoErroresPuesto = response.data.errores
                this.alertaErroresPuesto = true
              }
            })
          .catch(function (error) {
            console.log(error);
          })
        this.initialize()
      },

      cerrarDialogPuesto() {
        this.alertaErrores = false
        this.dialogPuestos = false
        //this.dialog = false
        this.$nextTick(() => {
          this.nuevoPuesto = Object.assign({}, this.defaultnuevoPuesto)
        })
      },

      cerrarDialogRegistro() {
        this.alertaErrores = false
        this.dialogPuestos = false
        this.dialog = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
          this.idUsuarioEditar = 0
        })
      },
    },
  }
</script>