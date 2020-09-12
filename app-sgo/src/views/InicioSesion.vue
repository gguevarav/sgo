<template>
    <v-card
        class="mx-auto"
        max-width="400"
        >
        <v-img
            src="@/assets/images/logo.png"
            aspect-ratio="5"
            contain
            >
        </v-img>
        <v-card-text>
            <v-text-field
                label="Usuario"
                required>
            </v-text-field>
            <v-text-field
                v-model="password"
                :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                :rules="[rules.required, rules.min]"
                :type="show1 ? 'text' : 'password'"
                name="input-10-1"
                label="Contraseña"
                hint="At least 8 characters"
                counter
                @click:append="show1 = !show1">
            </v-text-field>
        </v-card-text>
        <v-card-actions>
            <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="cerrarDialogUM">Iniciar Sesión</v-btn>
        </v-card-actions>
    </v-card>
</template>

<script>
export default {
    name: 'InicioSesion',
    data () {
      return {
        show1: false,
        password: '',
        rules: {
          required: value => !!value || 'Required.',
          min: v => v.length >= 8 || 'Min 8 characters',
          emailMatch: () => ('The email and password you entered don\'t match'),
        },
      }
    },
}
</script>