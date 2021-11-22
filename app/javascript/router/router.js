import Vue from 'vue';
import VueRouter from 'vue-router';
import VueGtag from 'vue-gtag';
import store from '../store/index';

import HomePage from '../components/pages/HomePage';
import LoginPage from '../components/pages/LoginPage';
import MealSuggestionPage from '../components/pages/MealSuggestionPage';
import MyPage from '../components/pages/MyPage';
import MyPageAccount from '../components/parts/MyPageAccount';
import MyPageSetting from '../components/parts/MyPageSetting';
import MyPageWithdrawal from '../components/parts/MyPageWithdrawal';
import PrivacyPolicyPage from '../components/pages/PrivacyPolicyPage';
import RegisterPage from '../components/pages/RegisterPage';
import TopPage from '../components/pages/TopPage';

import NotFoundPage from '../components/pages/NotFoundPage';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopPage,
      name: 'TopPage',
      meta: { isPublic: true },
    },
    {
      path: '/register',
      component: RegisterPage,
      name: 'RegisterPage',
      meta: { isPublic: true },
    },
    {
      path: '/login',
      component: LoginPage,
      name: 'LoginPage',
      meta: { isPublic: true },
    },
    {
      path: '/privacy',
      component: PrivacyPolicyPage,
      name: 'PrivacyPolicyPage',
      meta: { isPublic: true },
    },
    // 以下、要ログイン
    {
      path: '/home',
      component: HomePage,
      name: 'HomePage',
    },
    {
      path: '/mypage',
      component: MyPage,
      children: [
        {
          path: 'setting',
          component: MyPageSetting,
          name: 'MyPageSetting',
        },
        {
          path: 'account',
          component: MyPageAccount,
          name: 'MyPageAccount',
        },
        {
          path: 'withdrawal',
          component: MyPageWithdrawal,
          name: 'MyPageWithdrawal',
        },
      ],
    },
    {
      path: '/suggestion',
      component: MealSuggestionPage,
      name: 'MealSuggestionPage',
    },
    // 404 not found
    {
      path: '*',
      component: NotFoundPage,
      meta: { isPublic: true },
    },
  ],
});

router.beforeEach((to, from, next) => {
  // isPublicでない=ログインが必要なページの場合
  if (to.matched.some((record) => !record.meta.isPublic)) {
    // かつログインしていない場合
    if (!store.state.authUser.isLoggedIn) {
      // ログインページにリダイレクトする
      next({
        path: '/login',
        query: { redirect: to.fullPath },
      });
    } else {
      next();
    }
  } else {
    next();
  }
});

Vue.use(
  VueGtag,
  {
    config: { id: 'UA-212123833-1' },
    appName: 'I Hate To Eat',
    pageTrackerScreenviewEnabled: true,
  },
  router
);

export default router;
