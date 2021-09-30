import Vue from 'vue';
import VueRouter from 'vue-router';

import TopPage from '../components/pages/TopPage';
import NotFound from '../components/pages/NotFound';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopPage,
      name: 'TopPage',
    },
    // 404 not found
    {
      path: '*',
      component: NotFound,
    },
  ],
});

export default router;
