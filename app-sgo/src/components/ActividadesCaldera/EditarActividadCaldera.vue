<template>
  <div>
    <v-icon
      small
      class="mr-2"
      @click="dialog = true">
      mdi-pencil
    </v-icon>
    <v-row
        justify="center">
      <v-dialog
        v-model="dialog"
        persistent
        max-width="600px"
      >
        <v-card>
          <v-card-title>
            <span class="headline">Editar actividad</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col
                    cols="12"
                    sm="6"
                    md="2"
                >
                  <v-text-field
                      label="Area"
                      v-model="actividadCaldera.NombreArea"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    md="2"
                >
                  <v-text-field
                      label="Caldera"
                      v-model="actividadCaldera.NombreCaldera"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    md="3"
                >
                  <v-text-field
                      label="Area caldera"
                      v-model="actividadCaldera.NombreAreaCaldera"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    md="5"
                >
                  <v-text-field
                      label="Actividad a realizar"
                      v-model="actividadCaldera.NombreActividad"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="4"
                    md="4"
                >
                  <v-text-field
                      label="Creado por"
                      v-model="actividadCaldera.CreadoPor"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="4"
                    md="4"
                >
                  <v-text-field
                      label="Fecha de creación"
                      v-model="actividadCaldera.FechaCreacionActividad"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="4"
                    md="4">
                  <v-select
                      :items="datosEstadoUsuario"
                      item-text='NombreEstadoUsuario'
                      item-value='idEstadoUsuario'
                      v-model="actividadCaldera.idEstado"
                      label="Estado">
                  </v-select>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
                color="blue darken-1"
                text
                @click="dialog = false"
            >
              Close
            </v-btn>
            <v-btn
                color="blue darken-1"
                text
                @click="cerrarActividadEstado"
            >
              Save
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";

export default {
name: "DetalleActividadCaldera",
  data: () => ({
    valid: true,
    dialog: false,
    idActividad: '',
    alertaErrores: false,
    listadoErrores: [],
    actividadCaldera: [],
    datosEstadoUsuario: [{
      idEstadoUsuario: 1,
      NombreEstadoUsuario: 'Activo'
    },
      {
        idEstadoUsuario: 4,
        NombreEstadoUsuario: 'Cerrado'
      }
    ],
    cambiarEstadoCerrar:[
      {
        EstadoActividad: '',
        RealizadoPor: localStorage.getItem('idUsuario'),
      }
    ]
  }),
  created() {
    this.obtenerActividadCambiarEstado()
    //console.log(this.Actividad)
  },
  props:['Actividad'],
  methods:{
    obtenerActividadCambiarEstado(){
      this.idActividad = this.Actividad
      return new Promise((resolve, reject) => {
        axios.get('/api/listadoactividadescaldera/' + this.idActividad)
            .then(response => {
              if (response.data.status == 200) {
                //console.log(response)
                this.actividadCaldera = response.data.detalle[0]
                //console.log(this.actividadCaldera)
                //this.cerrarDialog()
              } else if (response.data.status == 404) {
                //console.log("error")
                //this.listadoErrores = response.data.errores
                //this.alertaErrores = true
              }
              resolve(response)
            })
            .catch(error => {
              //console.log(error)

              reject(error)
            })
      })
    },
    cerrarActividadEstado(){
      // Debemos cerrar la actividad para que no aparezca en el tablero
      axios.post('/api/cerraractividad/' + this.idActividad,
              {
                EstadoActividad: this.actividadCaldera.idEstado,
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
      // Limpiamos todo
      //this.listadoProductosAgregar = [];
    },
  },
}
</script>

<style scoped>

</style>