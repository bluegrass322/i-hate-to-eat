const state = {
  pct: {
    protein: null,
    fat: null,
    carbohydrate: null,
  },
  amt: {
    protein: null,
    fat: null,
    carbohydrate: null,
  },
};

// TODO: 要リファクタリング、ただし現在当ストアは不使用のため優先度低い
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
// TODO: ここまで

const actions = {
  setStates(context, params) {
    context.commit('updatePct', params.pct);
    context.commit('updateAmt', params.amt);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
