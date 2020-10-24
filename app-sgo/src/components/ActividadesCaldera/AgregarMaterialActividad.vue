<template>
  <div>
    <v-row>
      <v-col cols="10">
        <small>Ingrese el material utilizado</small>
      </v-col>
      <v-col cols="2">
        <v-btn
            text
            small
            @click="agregarProducto">
          <v-icon>
            mdi-plus
          </v-icon>
        </v-btn>
      </v-col>
    </v-row>
    <!-- Notificación -->
    <v-snackbar
        v-model="activarNotificacion"
        :timeout="timeout"
        :color="colorNotificacion">
      {{ textoMostrarNotificacion }}
      <template
          v-slot:action="{ attrs }">
        <v-btn
            color="secondary"
            text
            v-bind="attrs"
            @click="activarNotificacion = !activarNotificacion">
          Close
        </v-btn>
      </template>
    </v-snackbar>
    <!-- Notificación -->
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
    <v-row v-for="(item, index) in listadoProductosAgregar" v-bind:key="index">
      <v-col
          cols="12"
          sm="8"
          md="8"
      >
        <v-autocomplete
            :items="listadoProductos"
            :item-text="NombreCodigoProducto"
            item-value='idProducto'
            v-model="item.idProducto"
            label="Producto">
        </v-autocomplete>
      </v-col>
      <v-col
          cols="12"
          sm="4"
          md="4"
      >
        <v-text-field
            v-model="item.CantidadProducto"
            label="Cantidad"
            type="number"
        ></v-text-field>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";

export default {
name: "AgregarMaterialActividad",
  data: () => ({
    dialog: false,
    activarNotificacion: false,
    timeout: 3000,
    colorNotificacion: 'success',
    textoMostrarNotificacion: '',
    listadoProductosAgregar: [],
    listadoProductos: [],
    alertaErrores: false,
    listadoErrores: [],
    idActividad: '',
  }),
  created() {
    this.inicializar();
  },
  methods:{
    agregarProducto(){
      this.listadoProductosAgregar.push(
          {
            idListadoActividadCaldera: this.idActividad,
            idProducto: '',
            CantidadProducto: '',
          }
      )
    },
    inicializar(){
      this.idActividad = this.Actividad;
      return new Promise((resolve, reject) => {
        axios.get('/api/productoinventariado')
            .then(response => {
              if (response.data.status == 200) {
                this.listadoProductos = response.data.detalle
                //this.cerrarDialog()
              } else if (response.data.status == 404) {
                this.listadoErrores = response.data.errores
                this.alertaErrores = true
              }
              resolve(response)
            })
            .catch(error => {
              //console.log(error)

              reject(error)
            })
      })
    },
    // Concatenando el codigo con el nombre
    NombreCodigoProducto: item => item.CodigoProducto + ' - ' + item.NombreProducto + ' - ' + item.TotalExistencia + ' - ' + item.AbreviacionUnidadMedida,

    // Guardamos los dados
    guardarDatosMateriales(){
      // Si vamos a cerrar el dialog o no
      // Guardamos el listado de materiales de la actividad
      this.listadoProductosAgregar.forEach(element => {
        // Guardamos todos los productos que seleccionamos
        return new Promise((resolve, reject) => {
          axios.post('/api/listadomaterialactividadescaldera', element)
              .then(response => {
                if (response.data.status == 200) {
                  //console.log(response);
                  this.descontarProductosInventario(element);
                  this.cambiarEstadoActividad();
                  this.$emit("dialog", this.dialog);
                  this.$emit("actualizar");
                  this.mostrarNotificacion();
                  //console.log(element)
                } else if (response.data.status == 404) {
                  this.listadoErrores = response.data.errores
                  this.alertaErrores = true
                }
                resolve(response)
              })
              .catch(error => {
                //console.log(error)

                reject(error)
              })
        })
      });
    },

    descontarProductosInventario(element){
      // Descontamos los productos del inventario
      // Guardamos todos los productos que seleccionamos
        return new Promise((resolve, reject) => {
          //console.log(element);
          axios.post('/api/descontarproductosinventario',
              {
                idProducto: element.idProducto,
                idListadoActividadCaldera: element.idListadoActividadCaldera,
                CantidadExistencia: element.CantidadProducto,
                RegistradoPor: localStorage.getItem('idUsuario'),
              })
              .then(response => {
                if (response.data.status == 200) {
                  //console.log(response);
                } else if (response.data.status == 404) {
                  this.listadoErrores = response.data.errores
                  this.alertaErrores = true
                }
                resolve(response)
              })
              .catch(error => {
                //console.log(error)

                reject(error)
              })
        })
    },
    cambiarEstadoActividad(){
      // Debemos cerrar la actividad para que no aparezca en el tablero
      axios.post('/api/cambiarestadoactividadcaldera/' + this.idActividad,
          {
            EstadoActividad: 2,
            RealizadoPor: localStorage.getItem('idUsuario'),
          })
          .then(response => {
            if (response.data.status == 200) {
              //console.log(response);
              this.dialog = false;
            } else if (response.data.status == 404) {
              this.listadoErrores = response.data.errores
              this.alertaErrores = true
            }
          })
          .catch(error => {
            //console.log(error)
          })
    },
    mostrarNotificacion(){
      this.textoMostrarNotificacion = 'Material registrado exitosamente';
      this.colorNotificacion = 'success';
      this.activarNotificacion = !this.activarNotificacion
    },
  },
  props:[
      'Actividad'
  ],
}

</script>

<style scoped>

</style>