<template>
  <v-row>
    <v-col cols="4">
      <v-row>
        <v-col>
          <h3>Calderas</h3>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-card
            color="red"
            dark>
            <v-card-title class="headline">Dosificación</v-card-title>
            <v-card-text>
              <div>Fecha de creación: 28 de agosto del 2020</div>
              <div>Creado por: Gemis Guevara</div>
            </v-card-text>

            <v-card-actions>
              <v-btn text>Editar</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-col>

    <v-col cols="4">
      <v-row>
        <v-col>
          <h3>Pretratamiento</h3>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-card
            color="yellow"
            >
            <v-card-title class="headline">Dosificación</v-card-title>
            <v-card-text>
              <div>Fecha de creación: 28 de agosto del 2020</div>
              <div>Creado por: Gemis Guevara</div>
            </v-card-text>

            <v-card-actions>
              <v-btn text>Editar</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-col>

    <v-col cols="4">
      <v-row>
        <v-col>
          <h3>Torre de enfriamiento</h3>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
         <v-card
            color="green"
            dark>
            <v-card-title class="headline">Dosificación</v-card-title>
            <v-card-text>
              <div>Fecha de creación: 28 de agosto del 2020</div>
              <div>Creado por: Gemis Guevara</div>
            </v-card-text>

            <v-card-actions>
              <v-btn text>Editar</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
  import axios from "axios";

  export default {
    data: () => ({
      toggle_exclusive: undefined,
      dialog: false,
      dialogUnidadMedida: false,
      headers: [{
          text: 'idProducto',
          align: 'start',
          sortable: false,
          value: 'idProducto',
        },
        {
          text: 'Código',
          value: 'CodigoProducto'
        },
        {
          text: 'Nombre del producto',
          value: 'NombreProducto'
        },
        {
          text: 'Unidad de medida',
          value: 'idUnidadMedida'
        },
        {
          text: 'Estado',
          value: 'EstadoProducto'
        },
        {
          text: 'Actions',
          value: 'actions',
          sortable: false
        },
      ],
      datosTabla: [],
      select: [],
      datosUnidadMedida: [],
      datosEstadoProducto: [{
          idEstadoProducto: 1,
          NombreEstadoProducto: 'Activo'
        },
        {
          idEstadoProducto: 0,
          NombreEstadoProducto: 'Inactivo'
        }
      ],
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
      formTitle() {
        return this.editedIndex === -1 ? 'Nuevo producto' : 'Editar producto'
      },
    },

    watch: {
      dialog(val) {
        val || this.close()
      },
    },

    created() {
      this.initialize()
    },

    methods: {
      initialize() {
        axios
          .get("http://localhost/api-sgo/productos")
          .then(response => {
            if (response.data.total != 0) {
              this.datosTabla = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
        axios
          .get("http://localhost/api-sgo/unidadesmedida")
          .then(response => {
            if (response.data.total != 0) {
              this.datosUnidadMedida = response.data.detalle
            }
          })
          .catch(function (error) {
            console.log(error);
          })
      },

      editarProducto(item, idProducto) {
        this.idProductoEditar = idProducto
        this.editedIndex = this.datosTabla.indexOf(item)
        this.editedItem = Object.assign({}, item)
        if (this.editedIndex > -1) {
          this.editarCodigo = true
        } else {
          this.editarCodigo = false
        }
        this.dialog = true
      },

      eliminarProducto(id) {
        confirm('¿Está seguro que desea eliminar este producto?') && axios
          .delete("http://localhost/api-sgo/productos/" + id)
          .then(function (response) {
            //console.log(response);
          })
          .catch(function (error) {
            console.log(error);
          })
      },

      guardarProducto() {
        // Si el valor del índice de edición es mayor al que se está editando entonces 
        if (this.editedIndex > -1) {
          axios
            .put("http://localhost/api-sgo/productos/" + this.idProductoEditar,
              this.editedItem)
            .then(function (response) {
              //console.log(response);
            })
            .catch(function (error) {
              console.log(error);
            })
        } else {
          axios
            .post("http://localhost/api-sgo/productos",
              this.editedItem)
            .then(function (response) {
              //console.log(response);
              //this.initialize()
            })
            .catch(function (error) {
              console.log(error);
            })
        }
        this.initialize()
        this.close()
      },

      guardarUnidadMedida() {
        axios
          .post("http://localhost/api-sgo/unidadesmedida",
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

      cerrarDialogUM() {
        this.dialogUnidadMedida = false
        this.dialog = false
        this.$nextTick(() => {
          this.nuevoUM = Object.assign({}, this.defaultNuevoUM)
        })
      },

      close() {
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