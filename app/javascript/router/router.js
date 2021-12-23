import Vue from 'vue';
import VueRouter from 'vue-router';
import VueGtag from 'vue-gtag';
import store from '../store/index';

// 各ページ
import AboutServicePage from '../components/pages/AboutServicePage';
import HomePage from '../components/pages/HomePage';
import LoginPage from '../components/pages/LoginPage';
import MealSuggestionPage from '../components/pages/MealSuggestionPage';
import MyPage from '../components/pages/MyPage';
import MyPageAccount from '../components/parts/MyPageAccount';
import MyPageSetting from '../components/parts/MyPageSetting';
import MyPageWithdrawal from '../components/parts/MyPageWithdrawal';
import PrivacyPolicyPage from '../components/pages/PrivacyPolicyPage';
import RegisterPage from '../components/pages/RegisterPage';
import TermsOfUsePage from '../components/pages/TermsOfUsePage';
import TopPage from '../components/pages/TopPage';

import NotFoundPage from '../components/pages/NotFoundPage';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    // 以下、パブリックページ
    {
      path: '/',
      component: TopPage,
      name: 'TopPage',
      meta: {
        isPublic: true,
      },
    },
    {
      path: '/register',
      component: RegisterPage,
      name: 'RegisterPage',
      meta: {
        isPublic: true,
        title: 'Register',
      },
    },
    {
      path: '/login',
      component: LoginPage,
      name: 'LoginPage',
      meta: {
        isPublic: true,
        title: 'Login',
      },
    },
    {
      path: '/about',
      component: AboutServicePage,
      name: 'AboutServicePage',
      meta: {
        isPublic: true,
        title: 'About',
      },
    },
    {
      path: '/terms',
      component: TermsOfUsePage,
      name: 'TermsOfUsePage',
      meta: {
        isPublic: true,
        title: 'Terms of use',
      },
    },
    {
      path: '/privacy',
      component: PrivacyPolicyPage,
      name: 'PrivacyPolicyPage',
      meta: {
        isPublic: true,
        title: 'Privacy policy',
      },
    },
    // 以下、要ログイン
    {
      path: '/home',
      component: HomePage,
      name: 'HomePage',
      meta: {
        title: 'Home',
      },
    },
    {
      path: '/mypage',
      component: MyPage,
      children: [
        {
          path: 'setting',
          component: MyPageSetting,
          name: 'MyPageSetting',
          meta: {
            title: 'Setting',
          },
        },
        {
          path: 'account',
          component: MyPageAccount,
          name: 'MyPageAccount',
          meta: {
            title: 'Account',
          },
        },
        {
          path: 'withdrawal',
          component: MyPageWithdrawal,
          name: 'MyPageWithdrawal',
          meta: {
            title: 'Withdrawal',
          },
        },
      ],
    },
    {
      path: '/suggestion',
      component: MealSuggestionPage,
      name: 'MealSuggestionPage',
      meta: {
        title: "Today's meal",
      },
    },
    // 404 not found
    {
      path: '*',
      component: NotFoundPage,
      meta: {
        isPublic: true,
        title: 'Not found',
      },
    },
  ],
});

router.beforeEach((to, from, next) => {
  // !isPublic == 要ログインページの場合
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
    appName: 'Eat this 4 now',
    pageTrackerScreenviewEnabled: true,
  },
  router
);

export default router;
