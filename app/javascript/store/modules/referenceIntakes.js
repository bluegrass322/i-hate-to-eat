const state = {
  vitamins: {
    vitamin_a: { label: 'ビタミンA', amount: '', unit: 'μgRAE' },
    vitamin_d: { label: 'ビタミンD', amount: '', unit: 'μg' },
    vitamin_e: { label: 'ビタミンE', amount: '', unit: 'mg' },
    vitamin_k: { label: 'ビタミンK', amount: '', unit: 'μg' },
    vitamin_b1: { label: 'ビタミンB1', amount: '', unit: 'mg' },
    vitamin_b2: { label: 'ビタミンB2', amount: '', unit: 'mg' },
    niacin: { label: 'ナイアシン', amount: '', unit: 'mgNE' },
    vitamin_b6: { label: 'ビタミンB6', amount: '', unit: 'mg' },
    vitamin_b12: { label: 'ビタミンB12', amount: '', unit: 'μg' },
    folate: { label: '葉酸', amount: '', unit: 'μg' },
    pantothenic_acid: { label: 'パントテン酸', amount: '', unit: 'mg' },
    biotin: { label: 'ビオチン', amount: '', unit: 'μg' },
    vitamin_c: { label: 'ビタミンC', amount: '', unit: 'mg' }
  },
  minerals: {
    potassium: { label: 'カリウム', amount: '', unit: 'mg' },
    calcium: { label: 'カルシウム', amount: '', unit: 'mg' },
    magnesium: { label: 'マグネシウム', amount: '', unit: 'mg' },
    phosphorus: { label: 'リン', amount: '', unit: 'mg' },
    iron: { label: '鉄', amount: '', unit: 'mg' },
    zinc: { label: '亜鉛', amount: '', unit: 'mg' },
    copper: { label: '銅', amount: '', unit: 'mg' },
    manganese: { label: 'マンガン', amount: '', unit: 'mg' },
    iodine: { label: 'ヨウ素', amount: '', unit: 'μg' },
    selenium: { label: 'セレン', amount: '', unit: 'μg' },
    chromium: { label: 'クロム', amount: '', unit: 'μg' },
    molybdenum: { label: 'モリブデン', amount: '', unit: 'μg' }
  }
};

const getters = {
  vitamins: (state) => state.vitamins,
  minerals: (state) => state.minerals,
};

const mutations = {
  // TODO: これでエラーは起こらず正しく動作するか？
  setVitamins(state, value) {
    Object.keys(state.vitamins).forEach(key => {
      state.vitamins[key].amount = value[key];
    });
  },
  setMinerals(state, value) {
    Object.keys(state.minerals).forEach(key => {
      state.minerals[key].amount = value[key];
    });
  }
};

const actions = {
  setAttributes(context, attr) {
    context.commit('setVitamins', attr);
    context.commit('setMinerals', attr);
  }
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};
