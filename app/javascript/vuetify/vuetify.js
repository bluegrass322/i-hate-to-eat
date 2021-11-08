import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#5a7899',
        secondary: '#2c4c6b',
        accent: '#f5f5f6',
        error: '#f74a62',
        warning: '#e5bc46',
        info: '#89a7ca',
        success: '#74a886',
      },
    },
  },
  icons: {
    iconfont: 'mdi',
  },
});
