import Vue from 'vue';

import {
  ValidationProvider,
  ValidationObserver,
  extend,
  setInteractionMode
} from 'vee-validate';

import {
  alpha_num,
  confirmed,
  email,
  min,
  required
} from 'vee-validate/dist/rules';

setInteractionMode('eager');

Vue.component('ValidationProvider', ValidationProvider);
Vue.component('ValidationObserver', ValidationObserver);

extend('alpha_num', {
  ...alpha_num,
  message: '{_field_}は英数字のみ使用できます'
});

extend('confirmed', {
  ...confirmed,
  message: 'パスワードと一致しません'
});

extend('email', {
  ...email,
  message: '形式を確認してください'
});

extend('min', {
  ...min,
  message: '{length}文字以上で入力してください'
});

extend('required', {
  ...required,
  message: '{_field_}を入力してください'
});