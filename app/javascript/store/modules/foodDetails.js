const state = {
  basicInfo: {
    name: '',
    subname: '',
    reference_amount: 1,
    description: '',
  },
  macro: {
    calorie: { label: 'カロリー', amount: '', unit: 'kcal' },
    protein: { label: 'タンパク質', amount: '', unit: 'g' },
    fat: { label: '脂質', amount: '', unit: 'g' },
    carbohydrate: { label: '炭水化物', amount: '', unit: 'g' },
  },
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
    vitamin_c: { label: 'ビタミンC', amount: '', unit: 'mg' },
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
    molybdenum: { label: 'モリブデン', amount: '', unit: 'μg' },
  },
};

const getters = {
  basicInfo: (state) => state.basicInfo,
  macro: (state) => state.macro,
  vitamins: (state) => state.vitamins,
  minerals: (state) => state.minerals,
};

const mutations = {
  // TODO: これでエラーは起こらず正しく動作するか？
  setInfo(state, value) {
    Object.keys(state.basicInfo).forEach((key) => {
      state.basicInfo[key] = value[key];
    });
  },
  // TODO: reference_amountを乗算する処理のリファクタリング
  setMacro(state, value) {
    Object.keys(state.macro).forEach((key) => {
      state.macro[key].amount = Math.trunc(
        value[key] * state.basicInfo.reference_amount
      );
    });
  },
  setVitamins(state, value) {
    Object.keys(state.vitamins).forEach((key) => {
      const origin = value[key] * state.basicInfo.reference_amount;
      const amount = trunc2ndDec(origin);
      state.vitamins[key].amount = amount;
    });
  },
  setMinerals(state, value) {
    Object.keys(state.minerals).forEach((key) => {
      const origin = value[key] * state.basicInfo.reference_amount;
      const amount = trunc2ndDec(origin);
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

// 小数第二位以下切り捨て用の関数
const trunc2ndDec = (original) => {
  let midCalc = original * 100;
  midCalc = Math.trunc(midCalc);
  const result = midCalc / 100;

  return result;
};
