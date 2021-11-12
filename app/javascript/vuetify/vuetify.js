import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#5a7899', // rgba(90, 120, 153, 1)
        secondary: '#2c4c6b', // rgba(44, 76, 107, 1)
        accent: '#f5f5f6', // rgba(245, 245, 246, 1)
        error: '#f74a62', // rgba(247, 74, 97, 1)
        warning: '#e5bc46', // rgba(229, 189, 70, 1)
        info: '#89a7ca', // rgba(137, 167, 202, 1)
        success: '#74a886', // rgba(116, 168, 134, 1)
      },
    },
  },
  icons: {
    iconfont: 'mdi',
  },
});
