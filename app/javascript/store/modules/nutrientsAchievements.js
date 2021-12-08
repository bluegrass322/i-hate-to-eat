const state = {
  macro: {
    calorie: { label: 'カロリー', total: null, unit: 'kcal', achv: null },
    protein: { label: 'タンパク質', total: null, unit: 'g', achv: null },
    fat: { label: '脂質', total: null, unit: 'g', achv: null },
    carbohydrate: { label: '炭水化物', total: null, unit: 'g', achv: null },
  },
  vitamins: {
    vitamin_a: { label: 'ビタミンA', total: null, unit: 'μgRAE', achv: null },
    vitamin_d: { label: 'ビタミンD', total: null, unit: 'μg', achv: null },
    vitamin_e: { label: 'ビタミンE', total: null, unit: 'mg', achv: null },
    vitamin_k: { label: 'ビタミンK', total: null, unit: 'μg', achv: null },
    vitamin_b1: { label: 'ビタミンB1', total: null, unit: 'mg', achv: null },
    vitamin_b2: { label: 'ビタミンB2', total: null, unit: 'mg', achv: null },
    niacin: { label: 'ナイアシン', total: null, unit: 'mgNE', achv: null },
    vitamin_b6: { label: 'ビタミンB6', total: null, unit: 'mg', achv: null },
    vitamin_b12: { label: 'ビタミンB12', total: null, unit: 'μg', achv: null },
    folate: { label: '葉酸', total: null, unit: 'μg', achv: null },
    pantothenic_acid: {
      label: 'パントテン酸',
      total: null,
      unit: 'mg',
      achv: null,
    },
    biotin: { label: 'ビオチン', total: null, unit: 'μg', achv: null },
    vitamin_c: { label: 'ビタミンC', total: null, unit: 'mg', achv: null },
  },
  minerals: {
    potassium: { label: 'カリウム', total: null, unit: 'mg', achv: null },
    calcium: { label: 'カルシウム', total: null, unit: 'mg', achv: null },
    magnesium: { label: 'マグネシウム', total: null, unit: 'mg', achv: null },
    phosphorus: { label: 'リン', total: null, unit: 'mg', achv: null },
    iron: { label: '鉄', total: null, unit: 'mg', achv: null },
    zinc: { label: '亜鉛', total: null, unit: 'mg', achv: null },
    copper: { label: '銅', total: null, unit: 'mg', achv: null },
    manganese: { label: 'マンガン', total: null, unit: 'mg', achv: null },
    iodine: { label: 'ヨウ素', total: null, unit: 'μg', achv: null },
    selenium: { label: 'セレン', total: null, unit: 'μg', achv: null },
    chromium: { label: 'クロム', total: null, unit: 'μg', achv: null },
    molybdenum: { label: 'モリブデン', total: null, unit: 'μg', achv: null },
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
      state.macro[key].total = Math.trunc(total[key]); // 少数は切り捨て
      state.macro[key].achv = achv[key];
    });
  },
  setVitamins(state, { total, achv }) {
    Object.keys(state.vitamins).forEach((key) => {
      state.vitamins[key].total = trunc2ndDec(total[key]); // 小数第3位以下は切り捨て
      state.vitamins[key].achv = achv[key];
    });
  },
  setMinerals(state, { total, achv }) {
    Object.keys(state.minerals).forEach((key) => {
      state.minerals[key].total = trunc2ndDec(total[key]); // 小数第3位以下は切り捨て
      state.minerals[key].achv = achv[key];
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

// 小数第3位以下切り捨て
const trunc2ndDec = (original) => {
  let midCalc = original * 100;
  midCalc = Math.trunc(midCalc);
  const result = midCalc / 100;

  return result;
};
