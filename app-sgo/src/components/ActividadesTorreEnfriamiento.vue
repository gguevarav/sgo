<template>
  <v-card>
    <v-card-title>
      Torre de enfriamiento
      <v-spacer></v-spacer>
      <v-dialog>
        <template
            v-slot:activator="{ on, attrs }">
          <v-btn
              text
              x-small
              @click="dialog = true">
            <v-icon>
              mdi-plus
            </v-icon>
          </v-btn>
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
        <v-row v-for="item in listadoActividadesTorreEnfriamiento">
          <v-col>
            <v-card
                :color="colorEstadoActividad(item.NombreEstado)">
              <v-card-title class="headline">{{ item.NombreActividad }}</v-card-title>
              <v-card-text>
                <div>Fecha de creación: {{ item.FechaCreacion }}</div>
                <div>Creado por: {{ item.CreadoPor }}</div>
              </v-card-text>

              <v-card-actions>
                <v-btn text>Editar</v-btn>
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

export default {
name: "ActividadesTorreEnfriamiento",
  data: () => ({
    listadoActividadesTorreEnfriamiento: [],
  }),
  created() {
    this.inicializar();
  },
  methods:{
    inicializar(){
      new Promise((resolve, reject) => {
        axios.get("/api/listadoactividadestorre")
            .then(response => {
              if (response.data.total != 0) {
                this.listadoActividadesTorreEnfriamiento = response.data.detalle
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