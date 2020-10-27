<template>
  <v-card
    flat>
    <v-card-title>
      Pretratamiento
      <v-spacer></v-spacer>
      <v-dialog>
        <template
            v-slot:activator="{ on, attrs }">
          <AgregarActividadPretratamiento
              @inicializar="inicializar">
          </AgregarActividadPretratamiento>
          <v-btn
              text
              x-small
              @click="inicializar">
            <v-icon>
              mdi-reload
            </v-icon>
          </v-btn>
        </template>
      </v-dialog>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row v-for="(item, index) in listadoActividadesPretratamiento" v-bind:key="index">
          <v-col>
            <v-card
                shaped
                elevation="10"
                :color="colorEstadoActividad(item.NombreEstado)">
              <v-card-title class="headline">{{ item.NombreActividad }}</v-card-title>
              <v-card-text>
                <div>Area: {{ item.NombreAreaPretratamiento }}</div>
                <div>Fecha de creación: {{ item.FechaCreacion }}</div>
                <div>Creado por: {{ item.CreadoPor }}</div>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <!-- Formulario para agregar productos actividad -->
                <DetalleActividadPretratamiento
                    :Actividad="item.idListadoActividadPretratamiento"
                    @inicializar="inicializar"
                    v-if="item.NombreEstado == 'Creado' ? true : false">
                </DetalleActividadPretratamiento>
                <!-- Formulario para agregar productos actividad -->
                <!-- Formulario para cambiar estado actividad -->
                <CambiarEstadoActividadPretratamiento
                    :ActividadCambiar="item.idListadoActividadPretratamiento"
                    @inicializar="inicializar"
                    v-if="item.NombreEstado == 'Creado' ? false : true">
                </CambiarEstadoActividadPretratamiento>
                <!-- Formulario para cambiar estado actividad -->
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
import axios from "axios";
import AgregarActividadPretratamiento from "@/components/ActividadesPretratamiento/AgregarActividadPretratamiento";

export default {
name: "ActividadesPretratamiento",
  components: {AgregarActividadPretratamiento},
  data: () => ({
    listadoActividadesPretratamiento: [],
  }),
  created() {
    this.inicializar();
  },
  methods:{
    inicializar(){
      new Promise((resolve, reject) => {
        axios.get("/api/listadoactividadespretratamiento")
            .then(response => {
              if (response.data.total != 0) {
                this.listadoActividadesPretratamiento = response.data.detalle
                //console.log(this.listadoActividadesCaldera)
              }
            })
            .catch(function (error) {
              console.log(error);
            })
      });
    },
    // Color por status de actividad
    colorEstadoActividad(estado) {
      if (estado == 'Creado') {
        return 'creado';
      } else if (estado == 'Activo') {
        return 'activo';
      } else if (estado == 'En proceso') {
        return 'enproceso';
      } else if (estado == 'Cerrado') {
        return 'cerrado';
      }
    }
  },
}
</script>

<style scoped>

</style>