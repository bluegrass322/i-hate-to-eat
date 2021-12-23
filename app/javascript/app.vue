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

export default {
  components: {
    FlashMessage,
    FooterMenu,
  },
  mounted() {
    const routeInstance = this.$route;
    this.createPageTitle(routeInstance);
  },
  // 戻り値を返す必要はないためwatchを使用
  watch: {
    '$route' (routeInstance, from) {
      this.createPageTitle(routeInstance);
    }
  },
  methods: {
    createPageTitle(routeInstance) {
      if (routeInstance.meta.title) {
        const pageTitle = routeInstance.meta.title + ' | Eat this 4 now';
        document.title = pageTitle;
      } else {
        document.title = 'Eat this 4 now';
      }
    },
  }
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
