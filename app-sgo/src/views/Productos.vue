<template>
  <div class="text-center">
    <v-snackbar
      v-model="snackbar"
      :timeout="timeout"
    >
      {{ textoSnackbar }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="success"
          text
          v-bind="attrs"
          @click="snackbar = false"
        >
          Close
        </v-btn>
      </template>
    </v-snackbar>
    <v-data-table
      :headers="headers"
      :items="datosTabla"
      :items-per-page="5"
      sort-by="NombreProducto"
      class="elevation-1"
    >
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>Productos</v-toolbar-title>
          <v-divider
            class="mx-4"
            inset
            vertical
          ></v-divider>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                text
                
                class="mb-2"
                v-bind="attrs"
                v-on="on">
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
            <v-card>
              <v-card-title>
                <span class="headline">{{ formTitle }}</span>
              </v-card-title>

              <v-card-text>
                <v-form>
                  <v-container>
                    <v-alert type="error" v-model="alertaErrores">
                      Los registros contienen los siguientes errores:
                          <li v-for="value in listadoErrores" v-bind:key>
                            {{ value }}
                          </li>
                    </v-alert>
                    <v-row
                      align="center"
                      justify="center">
                      <v-col cols="12" sm="6" md="6">
                        <v-text-field
                          v-model="editedItem.CodigoProducto"
                          :disabled="editarCodigo"
                          label="Código"
                          required>
                        </v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="6">
                        <v-text-field
                          v-model="editedItem.NombreProducto"
                          label="Nombre producto"
                          required>
                        </v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="6">
                        <v-btn-toggle
                          v-model="toggle_exclusive"
                          group
                          multiple>
                          <v-select  
                            :items="datosUnidadMedida"
                            item-text='NombreUnidadMedida'
                            item-value='idUnidadMedida'
                            v-model="editedItem.idUnidadMedida"
                            label="UnidadMedida"
                            required>
                          </v-select>
                          <v-btn
                            text
                            @click="dialogUnidadMedida = !dialogUnidadMedida">
                              <v-icon>
                              mdi-plus
                              </v-icon>
                          </v-btn>
                        </v-btn-toggle>
                      </v-col>
                      <v-col cols="12" sm="6" md="6">
                        <v-select  
                            :items="datosEstadoProducto"
                            item-text='NombreEstadoProducto'
                            item-value='idEstadoProducto'
                            v-model="editedItem.EstadoProducto"
                            label="Estado"
                            required>
                        </v-select>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="close">Cancelar</v-btn>
                <v-btn color="blue darken-1" text @click="guardarProducto">Guardar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-dialog v-model="dialogUnidadMedida" max-width="500px">
            <v-card>
              <v-card-title>
                <span class="headline">Nueva unidad de medida</span>
              </v-card-title>

              <v-card-text>
                <v-form>
                  <v-container>
                    <v-row
                      align="center"
                      justify="center">
                      <v-col cols="12" sm="6" md="6">
                        <v-text-field
                          v-model="nuevoUM.NombreUnidadMedida"
                          label="Nombre"
                          required>
                        </v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="6">
                        <v-text-field
                          v-model="nuevoUM.AbreviacionUnidadMedida"
                          label="Abreviatura"
                          required>
                        </v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="cerrarDialogUM">Cancelar</v-btn>
                <v-btn color="blue darken-1" text @click="guardarUnidadMedida">Guardar</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon
          small
          class="mr-2"
          @click="editarProducto(item, item.idProducto)"
        >
          mdi-pencil
        </v-icon>
        <v-icon
          small
          disabled
          @click="eliminarProducto(item.idProducto)"
        >
          mdi-delete
        </v-icon>
      </template>
    </v-data-table>
  </div>

</template>
        
<script>

    import axios from "axios";

    export default {
        data: () => ({
          snackbar: false,
          textoSnackbar: '',
          timeout: 3000,
          toggle_exclusive: undefined,
          dialog: false,
          dialogUnidadMedida: false,
          alertaErrores: false,
          headers: [
            {
              text: 'idProducto',
              align: 'start',
              sortable: false,
              value: 'idProducto',
            },
            { text: 'Código', value: 'CodigoProducto' },
            { text: 'Nombre del producto', value: 'NombreProducto' },
            { text: 'Unidad de medida', value: 'NombreUnidadMedida' },
            { text: 'Estado', value: 'NombreEstado' },
            { text: 'Actions', value: 'actions', sortable: false },
          ],
          listadoErrores: [],
          datosTabla: [],
          select: [],
          datosUnidadMedida: [],
          datosEstadoProducto: [{
            idEstadoProducto: 1,
            NombreEstadoProducto: 'Activo'
          },
          {
            idEstadoProducto: 2,
            NombreEstadoProducto: 'Inactivo'
          }],
          editedIndex: -1,
          idProductoEditar: 0,
          editarCodigo: false,
          editedItem: {
              CodigoProducto: '',
              NombreProducto: '',
              idUnidadMedida: '',
              EstadoProducto: '',
          },
          defaultItem: {
              CodigoProducto: '',
              NombreProducto: '',
              idUnidadMedida: '',
              EstadoProducto: '',
          },
          nuevoUM: {
              NombreUnidadMedida: '',
              AbreviacionUnidadMedida: '',
          },
          defaultNuevoUM: {
              NombreUnidadMedida: '',
              AbreviacionUnidadMedida: '',
          },
        }),

        computed: {
          formTitle () {
              return this.editedIndex === -1 ? 'Nuevo producto' : 'Editar producto'
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
                .get("http://localhost/sgo/api-sgo/public/productos")
                .then(response => {
                    if(response.data.total != 0){
                      this.datosTabla = response.data.detalle
                    }
                })
                .catch(function (error) {
                    console.log(error);
                })
              axios
                .get("http://localhost/sgo/api-sgo/public/unidadesmedida")
                .then(response => {
                    if(response.data.total != 0){
                      this.datosUnidadMedida = response.data.detalle
                    }
                })
                .catch(function (error) {
                    console.log(error);
                })
          },

          editarProducto (item, idProducto){
            this.idProductoEditar = idProducto
            this.editedIndex = this.datosTabla.indexOf(item)
            this.editedItem = Object.assign({}, item)
            if (this.editedIndex > -1){
              this.editarCodigo = true
            }else{
              this.editarCodigo = false
            }
            this.dialog = true
          },

          eliminarProducto(id){
            confirm('¿Está seguro que desea eliminar este producto?') && axios
                .delete("http://localhost/sgo/api-sgo/public/productos/" + id)
                .then(function (response) {
                    //console.log(response);
                })
                .catch(function (error) {
                    console.log(error);
                })
          },

          guardarProducto () {
            // Si el valor del índice de edición es mayor al que se está editando entonces 
            if (this.editedIndex > -1) {
              axios
                .put("http://localhost/sgo/api-sgo/public/productos/" + this.idProductoEditar,
                     this.editedItem)
                .then(response => {
                    //console.log(response);
                    // Cerramos el cuadro de diálogo y mostraremos una notificación
                    this.textoSnackbar = 'Producto editado exitosamente'
                    this.snackbar = !this.snackbar
                    this.close()
                })
                .catch(function (error) {
                    console.log(error);
                })
            } else {
              axios
                .post("http://localhost/sgo/api-sgo/public/productos", this.editedItem)
                .then(response => {
                    if(response.data.status == 200){
                      //console.log("exito")
                      // Mostramos la confirmación
                      this.textoSnackbar = 'Producto agregado exitosamente'
                      this.snackbar = !this.snackbar
                      this.close()
                    }else if(response.data.status == 404){
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

          guardarUnidadMedida (){
            axios
                .post("http://localhost/sgo/api-sgo/public/unidadesmedida",
                       this.nuevoUM)
                .then(function (response) {
                    //console.log(response);
                    //this.initialize()
                })
                .catch(function (error) {
                    console.log(error);
                })
            this.initialize()
            this.cerrarDialogUM()
          },

          cerrarDialogUM (){
            this.dialogUnidadMedida = false
            this.dialog = false
              this.$nextTick(() => {
                this.nuevoUM = Object.assign({}, this.defaultNuevoUM)
              })
          },

          close () {
              this.dialog = false
              this.$nextTick(() => {
                this.editedItem = Object.assign({}, this.defaultItem)
                this.editedIndex = -1
                this.idProductoEditar = 0
              })
          },
        },
    }
</script>