const state = {
  vitamins: {
    vitamin_a: { label: 'ビタミンA', amount: null, unit: 'μgRAE' },
    vitamin_d: { label: 'ビタミンD', amount: null, unit: 'μg' },
    vitamin_e: { label: 'ビタミンE', amount: null, unit: 'mg' },
    vitamin_k: { label: 'ビタミンK', amount: null, unit: 'μg' },
    vitamin_b1: { label: 'ビタミンB1', amount: null, unit: 'mg' },
    vitamin_b2: { label: 'ビタミンB2', amount: null, unit: 'mg' },
    niacin: { label: 'ナイアシン', amount: null, unit: 'mgNE' },
    vitamin_b6: { label: 'ビタミンB6', amount: null, unit: 'mg' },
    vitamin_b12: { label: 'ビタミンB12', amount: null, unit: 'μg' },
    folate: { label: '葉酸', amount: null, unit: 'μg' },
    pantothenic_acid: { label: 'パントテン酸', amount: null, unit: 'mg' },
    biotin: { label: 'ビオチン', amount: null, unit: 'μg' },
    vitamin_c: { label: 'ビタミンC', amount: null, unit: 'mg' },
  },
  minerals: {
    potassium: { label: 'カリウム', amount: null, unit: 'mg' },
    calcium: { label: 'カルシウム', amount: null, unit: 'mg' },
    magnesium: { label: 'マグネシウム', amount: null, unit: 'mg' },
    phosphorus: { label: 'リン', amount: null, unit: 'mg' },
    iron: { label: '鉄', amount: null, unit: 'mg' },
    zinc: { label: '亜鉛', amount: null, unit: 'mg' },
    copper: { label: '銅', amount: null, unit: 'mg' },
    manganese: { label: 'マンガン', amount: null, unit: 'mg' },
    iodine: { label: 'ヨウ素', amount: null, unit: 'μg' },
    selenium: { label: 'セレン', amount: null, unit: 'μg' },
    chromium: { label: 'クロム', amount: null, unit: 'μg' },
    molybdenum: { label: 'モリブデン', amount: null, unit: 'μg' },
  },
};

const getters = {
  vitamins: (state) => state.vitamins,
  minerals: (state) => state.minerals,
};

const mutations = {
  setVitamins(state, values) {
    Object.keys(state.vitamins).forEach((key) => {
      state.vitamins[key].amount = values[key];
    });
  },
  setMinerals(state, values) {
    Object.keys(state.minerals).forEach((key) => {
      state.minerals[key].amount = values[key];
    });
  },
};

const actions = {
  setStates(context, params) {
    context.commit('setVitamins', params);
    context.commit('setMinerals', params);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
