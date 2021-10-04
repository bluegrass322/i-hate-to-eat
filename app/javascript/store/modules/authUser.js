export const initialState = {
  userId: '',
  isLoggedIn: false
};

const mutations = {
  RESET_AUTHUSER_STATE(state) {
    Object.assign(state, JSON.parse(localStorage.getItem('initialState')));
  },
  login(state, userId) {
    state.userId = userId.id;
    state.isLoggedIn = true;
  }
};

export default {
  namespaced: true,
  state: initialState,
  mutations,
};