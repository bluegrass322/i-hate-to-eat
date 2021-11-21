const state = {
  type: 'success',
  message: null,
};

const getters = {
  type: (state) => state.type,
  message: (state) => state.message,
};

const mutations = {
  setMessage(state, { type, message, timeout }) {
    state.type = type;
    state.message = message;

    if (typeof timeout === 'undefined') {
      timeout = 3000;
    }

    setTimeout(() => {
      state.type = 'success';
      state.message = null;
    }, timeout);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
};
