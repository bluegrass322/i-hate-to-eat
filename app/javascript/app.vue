<template>
  <v-app>
    <flash-message class="flash-alert" />
    <v-main>
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
};
</script>

<style scoped>
#app {
  background-color: rgba(55, 56, 56, 1); /* #373838 */
}

/deep/ .v-main {
  /* info */
  border: 2px solid rgba(137, 167, 202, 1);
  box-sizing: border-box;
}

.flash-alert {
  margin: 0;
  align-self: center;
  padding: 25px 15px;
  position: fixed;
  z-index: 100;
}
</style>
