import Vue from 'vue';
import App from '../app.vue';

import axios from 'axios';
import axiosPlugin from '../plugins/vue-axios';
import { csrfToken } from '@rails/ujs';

import router from '../router/router';
import store from '../store/index';
import vuetify from '../vuetify/vuetify';
import * as veeValidate from '../plugins/vee-validate';

// ユーザーのログイン状態管理用
import { initialState } from '../store/modules/authUser';
import { checkAuthUserExpires } from '../plugins/check-auth-user';

Vue.use(axiosPlugin, { axios: axios, csrfToken: csrfToken });

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    veeValidate,
    vuetify,
    created() {
      localStorage.setItem('initialState', JSON.stringify(initialState));
    },
    mounted() {
      // ログインユーザーのexpiresAtをチェック
      // TODO: 書き換え可能なローカルストレージに期限を置くべきでない
      // TODO: バックエンドとの不整合も起こりうる
      const loggedIn = this.$store.state.authUser.isLoggedIn;
      const expiresAt = this.$store.state.authUser.expiresAt;

      if (loggedIn && expiresAt) {
        if (checkAuthUserExpires(expiresAt)) {
          this.$store.commit('authUser/RESET_AUTHUSER_STATE');
          this.$router.push({ name: 'LoginPage' });
        }
      }
    },
    render: (h) => h(App),
  }).$mount();
  document.body.appendChild(app.$el);
  // console.log(app);
});