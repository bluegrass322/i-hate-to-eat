import Vue from 'vue';
import { calcAge } from './vee-validate-func';

import {
  ValidationProvider,
  ValidationObserver,
  extend,
  setInteractionMode,
} from 'vee-validate';

import {
  alpha_num,
  confirmed,
  email,
  numeric,
  max_value,
  min,
  min_value,
  required,
} from 'vee-validate/dist/rules';

setInteractionMode('eager');

Vue.component('ValidationProvider', ValidationProvider);
Vue.component('ValidationObserver', ValidationObserver);

extend('alpha_num', {
  ...alpha_num,
  message: '{_field_}は英数字のみ使用できます',
});

extend('confirmed', {
  ...confirmed,
  message: 'パスワードと一致しません',
});

extend('email', {
  ...email,
  message: '形式を確認してください',
});

extend('numeric', {
  ...numeric,
  message: '数字で入力してください',
});

extend('max_value', {
  ...max_value,
  message: '{max}以上の数値は入力できません',
});

extend('min', {
  ...min,
  message: '{length}文字以上で入力してください',
});

extend('min_value', {
  ...min_value,
  message: '{min}以下の数値は入力できません',
});

extend('required', {
  ...required,
  message: '{_field_}を入力してください',
});

// Custom rules
extend('abailable_age', {
  message: '本サービスは18歳以上60歳未満の方が対象です',
  validate(value) {
    const age = calcAge(value);
    if (age >= 18 && age < 60) {
      return true;
    }
  },
});
