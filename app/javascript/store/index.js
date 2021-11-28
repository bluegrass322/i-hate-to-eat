import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import authUser from './modules/authUser';
import bmrParams from './modules/bmrParams';
import flashMessage from './modules/flashMessage';
import foodDetails from './modules/foodDetails';
import nutrientsAchievements from './modules/nutrientsAchievements';
import pfcBalance from './modules/pfcBalance';
import referenceIntakes from './modules/referenceIntakes';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    authUser,
    bmrParams,
    flashMessage,
    foodDetails,
    nutrientsAchievements,
    pfcBalance,
    referenceIntakes,
  },

  plugins: [
    createPersistedState({
      key: 'eatThis4Now',
      paths: ['authUser.userId', 'authUser.isLoggedIn', 'authUser.expiresAt'],
      storage: window.localStorage,
    }),
  ],
});

export default store;
