import Vue from 'vue';
import VueRouter from 'vue-router';

import TopPage from '../components/pages/TopPage';
import RegisterPage from '../components/pages/RegisterPage';
import LoginPage from '../components/pages/LoginPage';
import NotFound from '../components/pages/NotFound';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopPage,
      name: 'TopPage',
      children: [
        {
          path: 'register',
          component: RegisterPage,
          name: 'RegisterPage',
        },
        {
          path: 'login',
          component: LoginPage,
          name: 'LoginPage',
        },
      ],
    },
    // 404 not found
    {
      path: '*',
      component: NotFound,
    },
  ],
});

export default router;
