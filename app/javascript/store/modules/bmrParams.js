const state = {
  user: {
    gender: '',
    birth: '',
    height: '',
    weight: '',
  },
  bmr: '',
};

// TODO: 要リファクタリング
const mutations = {
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

// TODO: 要リファクタリング
const actions = {
  setAttributes(context, attributes) {
    context.commit('updateGender', attributes.gender);
    context.commit('updateBirth', attributes.birth);
    context.commit('updateHeight', attributes.height);
    context.commit('updateWeight', attributes.weight);
    context.commit('updateBmr', attributes.bmr);
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};
