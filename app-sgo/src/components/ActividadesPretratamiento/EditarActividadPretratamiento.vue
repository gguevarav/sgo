<template>
  <div>
    <v-icon
      small
      class="mr-2"
      @click="dialog = true">
      mdi-pencil
    </v-icon>
    <v-row justify="center">
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
                    md="4"
                >
                  <v-text-field
                      label="Area"
                      v-model="actividadPretratamiento.NombreArea"
                      disabled
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                    md="3"
                >
                  <v-text-field
                      label="Area pretratamiento"
                      v-model="actividadPretratamiento.NombreAreaPretratamiento"
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
                      v-model="actividadPretratamiento.NombreActividad"
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
                      v-model="actividadPretratamiento.CreadoPor"
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
                      v-model="actividadPretratamiento.FechaCreacionActividad"
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
                      v-model="actividadPretratamiento.idEstado"
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
name: "DetalleActividadPretratamiento",
  data: () => ({
    valid: true,
    dialog: false,
    idActividad: '',
    alertaErrores: false,
    listadoErrores: [],
    actividadPretratamiento: [],
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
        axios.get('/api/listadoactividadespretratamiento/' + this.idActividad)
            .then(response => {
              if (response.data.status == 200) {
                //console.log(response)
                this.actividadPretratamiento = response.data.detalle[0]
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
      axios.post('/api/cerraractividadpretratamiento/' + this.idActividad,
              {
                EstadoActividad: this.actividadPretratamiento.idEstado,
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
      // Recargamos
      //this.obtenerActividadCambiarEstado();
    },
  },
}
</script>

<style scoped>

</style>