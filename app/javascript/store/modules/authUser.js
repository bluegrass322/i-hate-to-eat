export const initialState = {
  userId: null,
  isLoggedIn: false,
  expiresAt: null,
};

const getters = {
  isLoggedIn: (state) => state.isLoggedIn,
};

const mutations = {
  RESET_AUTHUSER_STATE(state) {
    Object.assign(state, JSON.parse(localStorage.getItem('initialState')));
  },
  login(state, { userId, expires }) {
    state.userId = userId.id;
    state.expiresAt = expires;
    state.isLoggedIn = true;
  },
};

export default {
  namespaced: true,
  state: initialState,
  getters,
  mutations,
};
