<template>
  <div>
    <v-app>
      <v-card>
        <v-card-title>
          Caldera
          <v-spacer></v-spacer>
          <v-dialog>
            <template
                v-slot:activator="{ on, attrs }">
              <AgregarActividadCaldera></AgregarActividadCaldera>
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
            <v-row v-for="(item, index) in  listadoActividadesCaldera" v-bind:key="index">
              <v-col>
                <v-card
                    :color="colorEstadoActividad(item.NombreEstado)">
                  <v-card-title class="headline">{{ item.NombreActividad }}</v-card-title>
                  <v-card-text>
                    <div>Caldera: {{ item.NombreCaldera }}</div>
                    <div>Area: {{ item.NombreAreaCaldera }}</div>
                    <div>Fecha de creación: {{ item.FechaCreacionActividad }}</div>
                    <div>Creado por: {{ item.CreadoPor }}</div>
                  </v-card-text>

                  <v-card-actions>
                    <!-- Formulario para cerrar actividad -->
                    <DetalleActividadCaldera :Actividad="item.idListadoActividadCaldera">
                    </DetalleActividadCaldera>
                    <!-- Formulario para cerrar actividad -->
                    <v-spacer></v-spacer>
                  </v-card-actions>
                </v-card>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-app>
  </div>
</template>

<script>
import axios from "axios";

export default {
name: "ActividadesCaldera",
  data: () => ({
    listadoActividadesCaldera: [],
  }),
  created(){
    this.inicializar();
  },
  methods: {
    inicializar(){
      new Promise((resolve, reject) => {
        axios.get("/api/listadoactividadescaldera")
            .then(response => {
              if (response.data.total != 0) {
                this.listadoActividadesCaldera = response.data.detalle
                //console.log(this.listadoActividadesCaldera)
              }
            })
            .catch(function (error) {
              console.log(error);
            })
      });
    },
    // Color por status de actividad
    colorEstadoActividad(estado){
      if(estado == 'Activo'){
        return 'red';
      }else if(estado == 'En proceso'){
        return 'yellow';
      }else if(estado == 'Cerrado') {
        return 'green';
      }
    },
  },
}
</script>

<style scoped>

</style>