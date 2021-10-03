import Vue from 'vue';
import Vuex from 'vuex';

import flashMessage from './modules/flashMessage';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    flashMessage,
  },
});

export default store;
