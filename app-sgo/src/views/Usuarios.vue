<template>
  <v-data-table
    :headers="headers"
    :items="datosTabla"
    :items-per-page="5"
    sort-by="NombreUsuario"
    class="elevation-1"
  >
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Usuarios</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              color="primary"
              dark
              class="mb-2"
              v-bind="attrs"
              v-on="on"
            >Nuevo usuario</v-btn>
            <v-btn
              text
              @click="initialize">
              <v-icon>
                mdi-reload
              </v-icon>
            </v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="6">
                    <v-text-field v-model="editedItem.NombreUsuario" label="Nombre"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="6">
                    <v-text-field v-model="editedItem.ApellidoUsuario" label="Apellido"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="6">
                    <v-text-field v-model="editedItem.CorreoUsuario" :disabled="editarCorreo" label="Correo"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="6">
                    <v-text-field v-model="editedItem.ContraseniaUsuario" label="Contraseña"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="12" md="12">
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
                              required>
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
                  <v-col cols="12" sm="6" md="6">
                    <v-select  
                        :items="datosRoles"
                        item-text='NombreRol'
                        item-value='idRol'
                        v-model="editedItem.idRol"
                        label="Rol"
                        required>
                    </v-select>
                  </v-col>
                   <v-col cols="12" sm="6" md="6">
                    <v-select  
                        :items="datosEstadoUsuario"
                        item-text='NombreEstadoUsuario'
                        item-value='idEstadoUsuario'
                        v-model="editedItem.EstadoUsuario"
                        :disabled="estadoHabilitado"
                        label="Estado"
                        required>
                    </v-select>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancelar</v-btn>
              <v-btn color="blue darken-1" text @click="guardarInformacion">Guardar</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <v-dialog v-model="dialogPuestos" max-width="500px">
          <v-card>
            <v-card-title>
              <span class="headline">Nuevo puesto</span>
            </v-card-title>

            <v-card-text>
              <v-form>
                <v-container>
                  <v-row
                    align="center"
                    justify="center">
                    <v-col cols="12">
                      <v-text-field
                        v-model="nuevoPuesto.NombrePuesto"
                        label="Nombre"
                        required>
                      </v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-form>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="cerrarDialogPuesto">Cancelar</v-btn>
              <v-btn color="blue darken-1" text @click="guardarPuesto">Guardar</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.actions="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editarUsuario(item, item.idUsuario)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        disabled
        @click="eliminarUsuario(item.idUsuario)"
      >
        mdi-delete
      </v-icon>
    </template>
  </v-data-table>
</template>
        
<script>

    import axios from "axios";

    export default {
        data: () => ({
          toggle_exclusive: undefined,
          dialog: false,
          dialogPuestos: false,
          headers: [
              {
                  text: 'idUsuario',
                  align: 'start',
                  sortable: false,
                  value: 'idUsuario',
              },
              { text: 'Nombre', value: 'NombreUsuario' },
              { text: 'Apellido', value: 'ApellidoUsuario' },
              { text: 'Puesto', value: 'idPuesto' },
              { text: 'Correo', value: 'CorreoUsuario' },
              { text: 'Rol', value: 'idRol' },
              { text: 'Estado', value: 'EstadoUsuario' },
              { text: 'Actions', value: 'actions', sortable: false },
              ],
          datosTabla: [],
          select: [],
          datosPuestos: [],
          datosRoles: [],
          datosEstadoUsuario: [{
            idEstadoUsuario: 1,
            NombreEstadoUsuario: 'Activo'
          },
          {
            idEstadoUsuario: 0,
            NombreEstadoUsuario: 'Inactivo'
          }],
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
          formTitle () {
              return this.editedIndex === -1 ? 'Nuevo usuario' : 'Editar usuario'
          },
        },

        watch: {
          dialog (val) {
              val || this.close()
          },
        },

        created () {
          this.initialize()
        },

        methods: {
          initialize () {
            axios
                .get("http://localhost/sgo/api-sgo/public/usuarios")
                .then(response => {
                    if(response.data.total != 0){
                      this.datosTabla = response.data.detalle
                    }
                })
                .catch(function (error) {
                    console.log(error);
                })
              axios
                .get("http://localhost/sgo/api-sgo/public/puestos")
                .then(response => {
                    if(response.data.total != 0){
                      this.datosPuestos = response.data.detalle
                    }
                })
                .catch(function (error) {
                    console.log(error);
                })
              axios
                .get("http://localhost/sgo/api-sgo/public/roles")
                .then(response => {
                    if(response.data.total != 0){
                      this.datosRoles = response.data.detalle
                    }
                })
                .catch(function (error) {
                    console.log(error);
                })
          },

          editarUsuario (item, idUsuario){
            this.idUsuarioEditar = idUsuario
            this.editedIndex = this.datosTabla.indexOf(item)
            this.editedItem = Object.assign({}, item)
            if (this.editedIndex > -1){
              this.editarCorreo = true
              this.estadoHabilitado = false
            }else{
              this.editarCorreo = false
              this.estadoHabilitado = true
            }
            this.dialog = true
          },

          eliminarUsuario(id){
            confirm('¿Está seguro que desea eliminar este usuario?') && axios
                .delete("http://localhost/sgo/api-sgo/public/usuarios/" + id)
                .then(function (response) {
                    //console.log(response);
                })
                .catch(function (error) {
                    console.log(error);
                })
          },

          guardarInformacion () {
            // Si el valor del índice de edición es mayor al que se está editando entonces 
            if (this.editedIndex > -1) {
              axios
                .put("http://localhost/sgo/api-sgo/public/usuarios/" + this.idUsuarioEditar,
                     this.editedItem)
                .then(function (response) {
                    //console.log(response);
                })
                .catch(function (error) {
                    console.log(error);
                })
            } else {
              axios
                .post("http://localhost/sgo/api-sgo/public/usuarios",
                       this.editedItem)
                .then(function (response) {
                    console.log(response);
                    //this.initialize()
                })
                .catch(function (error) {
                    console.log(error);
                })
            }
            this.initialize()
            this.close()
          },

          guardarPuesto (){
            axios
                .post("http://localhost/sgo/api-sgo/public/puestos",
                       this.nuevoPuesto)
                .then(function (response) {
                    //console.log(response);
                    //this.initialize()
                })
                .catch(function (error) {
                    console.log(error);
                })
            this.initialize()
            this.cerrarDialogPuesto()
          },

          cerrarDialogPuesto (){
            this.dialogPuestos = false
            this.dialog = false
              this.$nextTick(() => {
                this.nuevoPuesto = Object.assign({}, this.defaultnuevoPuesto)
              })
          },

          close () {
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