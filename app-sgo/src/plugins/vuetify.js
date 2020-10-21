import Vue from 'vue';
import Vuetify from 'vuetify/lib';

Vue.use(Vuetify);

import colors from "vuetify/lib/util/colors";

export default new Vuetify({
    theme: {
        themes: {
            light: {
                primary: colors.teal.darken3,
                secondary: colors.green.darken4,
                accent: colors.shades.black,
                error: colors.green.accent4,
                activo: colors.teal.darken1,
                enproceso: colors.yellow.darken3,
                cerrado: colors.green.darken2,
            },
            dark: {
                primary: colors.blue.lighten3,
            },
        },
    },
});
