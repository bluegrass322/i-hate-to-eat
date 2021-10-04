import Vue from 'vue';
import VueRouter from 'vue-router';
import store from '../store/index';

import TopPage from '../components/pages/TopPage';
import RegisterPage from '../components/pages/RegisterPage';
import LoginPage from '../components/pages/LoginPage';
import HomePage from '../components/pages/HomePage';
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
      children: [
        {
          path: 'register',
          component: RegisterPage,
          name: 'RegisterPage',
          meta: { isPublic: true },
        },
        {
          path: 'login',
          component: LoginPage,
          name: 'LoginPage',
          meta: { isPublic: true },
        },
      ],
    },
    {
      path: '/home',
      component: HomePage,
      name: 'HomePage',
      meta: { requiresAuth: true },
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

export default router;
