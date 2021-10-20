const state = {
  pct: {
    protein: '',
    fat: '',
    carbohydrate: '',
  },
  amt: {
    protein: '',
    fat: '',
    carbohydrate: '',
  },
};

const getters = {
  pct: (state) =>
    Object.keys(state.pct).forEach((key) => {
      state.pct[key] *= 100;
    }),
  amt: (state) => state.amt,
};

const mutations = {
  updatePct(state, value) {
    state.pct.protein = value.protein;
    state.pct.fat = value.fat;
    state.pct.carbohydrate = value.carbohydrate;
  },
  updateAmt(state, value) {
    state.amt.protein = value.protein;
    state.amt.fat = value.fat;
    state.amt.carbohydrate = value.carbohydrate;
  },
};

const actions = {
  setAttributes(context, attr) {
    context.commit('updatePct', attr.pct);
    context.commit('updateAmt', attr.amt);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
