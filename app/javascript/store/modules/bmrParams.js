const state = {
  user: {
    gender: null,
    birth: null,
    height: null,
    weight: null,
  },
  bmr: null,
};

const mutations = {
  updateStates(state, params) {
    Object.keys(state.user).forEach((key) => {
      state.user[key] = params[key];
    });
    state.bmr = params.bmr
  },
  updateGender(state, gender) {
    state.user.gender = gender;
  },
  updateBirth(state, birth) {
    state.user.birth = birth;
  },
  updateHeight(state, height) {
    state.user.height = height;
  },
  updateWeight(state, weight) {
    state.user.weight = weight;
  },
  updateBmr(state, bmr) {
    state.bmr = bmr;
  },
};

const actions = {
  setStates(context, params) {
    context.commit('updateStates', params);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
