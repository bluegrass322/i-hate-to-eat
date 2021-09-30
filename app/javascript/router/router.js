import Vue from 'vue';
import VueRouter from 'vue-router';

import TopPage from '../components/pages/TopPage';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopPage,
      name: 'TopPage',
    }
  ],
});

export default router;
