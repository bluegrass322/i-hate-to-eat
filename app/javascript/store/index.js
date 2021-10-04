import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import authUser from './modules/authUser';
import flashMessage from './modules/flashMessage';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    authUser,
    flashMessage,
  },

  plugins: [
    createPersistedState({
      key: 'iHateToEat',
      paths: ['authUser.userId', 'authUser.isLoggedIn'],
      storage: window.localStorage,
    }),
  ],
});

export default store;
