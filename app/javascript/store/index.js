import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import flashMessage from './modules/flashMessage';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    flashMessage,
  },

  plugins: [createPersistedState()],
});

export default store;
