import Vue from 'vue';
import VueRouter from 'vue-router';
import VueGtag from 'vue-gtag';
import store from '../store/index';

import TopPage from '../components/pages/TopPage';
import RegisterPage from '../components/pages/RegisterPage';
import LoginPage from '../components/pages/LoginPage';
import MealSuggestionPage from '../components/pages/MealSuggestionPage';
import HomePage from '../components/pages/HomePage';
import MyPage from '../components/pages/MyPage';
import NotFound from '../components/pages/NotFound';

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
    // 以下、要ログイン
    {
      path: '/home',
      component: HomePage,
      name: 'HomePage',
    },
    {
      path: '/mypage',
      component: MyPage,
      name: 'MyPage',
    },
    {
      path: '/suggestion',
      component: MealSuggestionPage,
      name: 'MealSuggestionPage',
    },
    // 404 not found
    {
      path: '*',
      component: NotFound,
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

Vue.use(VueGtag, {
  config: { id: 'UA-212123833-1'},
  appName: 'I Hate To Eat',
  pageTrackerScreenviewEnabled: true,
}, router);

export default router;
