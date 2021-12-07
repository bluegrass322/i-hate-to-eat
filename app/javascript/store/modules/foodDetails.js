const state = {
  basicInfo: {
    name: null,
    subname: null,
    reference_amount: 1,
    description: null,
  },
  macro: {
    calorie: { label: 'カロリー', amount: null, unit: 'kcal' },
    protein: { label: 'タンパク質', amount: null, unit: 'g' },
    fat: { label: '脂質', amount: null, unit: 'g' },
    carbohydrate: { label: '炭水化物', amount: null, unit: 'g' },
  },
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
  basicInfo: (state) => state.basicInfo,
  macro: (state) => state.macro,
  vitamins: (state) => state.vitamins,
  minerals: (state) => state.minerals,
};

const mutations = {
  setInfo(state, value) {
    Object.keys(state.basicInfo).forEach((key) => {
      state.basicInfo[key] = value[key];
    });
  },
  // TODO: reference_amountを乗算する処理のリファクタリング
  setMacro(state, value) {
    Object.keys(state.macro).forEach((key) => {
      state.macro[key].amount = Math.trunc(
        value[key] * value.reference_amount
      );
    });
  },
  setVitamins(state, value) {
    Object.keys(state.vitamins).forEach((key) => {
      const origin = value[key] * value.reference_amount;
      const amount = trunc2ndDec(origin); // 小数第3位以下は切り捨て

      state.vitamins[key].amount = amount;
    });
  },
  setMinerals(state, value) {
    Object.keys(state.minerals).forEach((key) => {
      const origin = value[key] * value.reference_amount;
      const amount = trunc2ndDec(origin); // 小数第3位以下は切り捨て

      state.minerals[key].amount = amount;
    });
  },
};

const actions = {
  setAttributes(context, attr) {
    context.commit('setInfo', attr);
    context.commit('setMacro', attr);
    context.commit('setVitamins', attr);
    context.commit('setMinerals', attr);
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
