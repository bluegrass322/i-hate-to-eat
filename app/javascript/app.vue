<template>
  <v-app>
    <flash-message class="flash-alert" />
    <v-main id="main-group">
      <v-container fluid fill-height class="ma-0 pa-0">
        <router-view />
      </v-container>
    </v-main>
    <footer-menu />
  </v-app>
</template>

<script>
import FlashMessage from './components/commons/FlashMessage';
import FooterMenu from './components/commons/FooterMenu';

// descriptionの定義ファイル
import { DESC_COMMON, DESC_DEFAULT } from './constants/page-descriptions';

export default {
  components: {
    FlashMessage,
    FooterMenu,
  },
  // 戻り値を返す必要はないためwatchを使用
  watch: {
    $route(routeInstance) {
      this.createPageTitle(routeInstance);
      this.createPageDesc(routeInstance);
    },
  },
  mounted() {
    const routeInstance = this.$route;

    this.createPageTitle(routeInstance);
    this.createPageDesc(routeInstance);
  },
  methods: {
    createPageTitle(routeInstance) {
      const commonTitle = 'Eat this 4 now';

      if (routeInstance.meta.title) {
        const pageTitle = routeInstance.meta.title + ' | ' + commonTitle;
        document.title = pageTitle;
      } else {
        document.title = commonTitle;
      }
    },
    createPageDesc(routeInstance) {
      let pageDesc = DESC_COMMON;

      if (routeInstance.meta.desc) {
        pageDesc = routeInstance.meta.desc + ' | Eat this 4 now';
      } else {
        pageDesc = pageDesc + DESC_DEFAULT;
      }

      document
        .querySelector("meta[name='description']")
        .setAttribute('content', pageDesc);
    },
  },
};
</script>

<style scoped>
#app {
  background-color: rgba(55, 56, 56, 1); /* #373838 */
}

#main-group.v-main {
  border: 2px solid rgba(137, 167, 202, 1);
  box-sizing: border-box;
}

.flash-alert {
  margin: 0;
  align-self: center;
  padding: 25px 15px;
  position: fixed;
  z-index: 1000;
}
</style>
