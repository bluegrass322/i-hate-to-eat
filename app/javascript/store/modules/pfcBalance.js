const state = {
  pct: {
    pctP: '',
    pctF: '',
    pctC: '',
  },
  amt: {
    amtP: '',
    amtF: '',
    amtC: '',
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
    state.pct.pctP = value.pct_p;
    state.pct.pctF = value.pct_f;
    state.pct.pctC = value.pct_c;
  },
  updateAmt(state, value) {
    state.amt.amtP = value.amt_p;
    state.amt.amtF = value.amt_f;
    state.amt.amtC = value.amt_c;
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
