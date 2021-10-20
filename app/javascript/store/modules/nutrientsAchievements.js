const state = {
  macro: {
    calorie: { label: 'カロリー', total: '', unit: 'kcal', achv: '' },
    protein: { label: 'タンパク質', total: '', unit: 'g', achv: '' },
    fat: { label: '脂質', total: '', unit: 'g', achv: '' },
    carbohydrate: { label: '炭水化物', total: '', unit: 'g', achv: '' },
  },
  vitamins: {
    vitamin_a: { label: 'ビタミンA', total: '', unit: 'μgRAE', achv: '' },
    vitamin_d: { label: 'ビタミンD', total: '', unit: 'μg', achv: '' },
    vitamin_e: { label: 'ビタミンE', total: '', unit: 'mg', achv: '' },
    vitamin_k: { label: 'ビタミンK', total: '', unit: 'μg', achv: '' },
    vitamin_b1: { label: 'ビタミンB1', total: '', unit: 'mg', achv: '' },
    vitamin_b2: { label: 'ビタミンB2', total: '', unit: 'mg', achv: '' },
    niacin: { label: 'ナイアシン', total: '', unit: 'mgNE', achv: '' },
    vitamin_b6: { label: 'ビタミンB6', total: '', unit: 'mg', achv: '' },
    vitamin_b12: { label: 'ビタミンB12', total: '', unit: 'μg', achv: '' },
    folate: { label: '葉酸', total: '', unit: 'μg', achv: '' },
    pantothenic_acid: {
      label: 'パントテン酸',
      total: '',
      unit: 'mg',
      achv: '',
    },
    biotin: { label: 'ビオチン', total: '', unit: 'μg', achv: '' },
    vitamin_c: { label: 'ビタミンC', total: '', unit: 'mg', achv: '' },
  },
  minerals: {
    potassium: { label: 'カリウム', total: '', unit: 'mg', achv: '' },
    calcium: { label: 'カルシウム', total: '', unit: 'mg', achv: '' },
    magnesium: { label: 'マグネシウム', total: '', unit: 'mg', achv: '' },
    phosphorus: { label: 'リン', total: '', unit: 'mg', achv: '' },
    iron: { label: '鉄', total: '', unit: 'mg', achv: '' },
    zinc: { label: '亜鉛', total: '', unit: 'mg', achv: '' },
    copper: { label: '銅', total: '', unit: 'mg', achv: '' },
    manganese: { label: 'マンガン', total: '', unit: 'mg', achv: '' },
    iodine: { label: 'ヨウ素', total: '', unit: 'μg', achv: '' },
    selenium: { label: 'セレン', total: '', unit: 'μg', achv: '' },
    chromium: { label: 'クロム', total: '', unit: 'μg', achv: '' },
    molybdenum: { label: 'モリブデン', total: '', unit: 'μg', achv: '' },
  },
};

const getters = {
  macro: (state) => state.macro,
  vitamins: (state) => state.vitamins,
  minerals: (state) => state.minerals,
};

const mutations = {
  setMacro(state, { total, achv }) {
    Object.keys(state.macro).forEach((key) => {
      state.macro[key].total = total[key];
      state.macro[key].achv = Math.trunc(achv[key] * 100);
    });
  },
  setVitamins(state, { total, achv }) {
    Object.keys(state.vitamins).forEach((key) => {
      state.vitamins[key].total = total[key];
      state.vitamins[key].achv = Math.trunc(achv[key] * 100);
    });
  },
  setMinerals(state, { total, achv }) {
    Object.keys(state.minerals).forEach((key) => {
      state.minerals[key].total = total[key];
      state.minerals[key].achv = Math.trunc(achv[key] * 100);
    });
  },
};

const actions = {
  setAttributes(context, { totals, achvs }) {
    context.commit('setMacro', { total: totals, achv: achvs });
    context.commit('setVitamins', { total: totals, achv: achvs });
    context.commit('setMinerals', { total: totals, achv: achvs });
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
