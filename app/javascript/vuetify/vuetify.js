import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import '@mdi/font/css/materialdesignicons.css';

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    light: {
      base: 'F5F5F6',
      primary: '5A7899',
      pLight: '89A7CA',
      pDark:'2C4C6B'
    }
  },
  icons: {
    iconfont: 'mdi'
  }
});
