<template>
  <v-app>
    <flash-message class="flash-alert" />
    <common-header />
    <v-main>
      <v-container fluid fill-height class="ma-0 pa-0">
        <router-view />
      </v-container>
    </v-main>
    <footer-menu />>
  </v-app>
</template>

<script>
import CommonHeader from './components/commons/CommonHeader';
import FlashMessage from './components/commons/FlashMessage';
import FooterMenu from './components/commons/FooterMenu';

export default {
  components: {
    CommonHeader,
    FlashMessage,
    FooterMenu,
  },
};
</script>

<style scoped>
#app {
  /* secondary */
  background-color: rgba(44, 76, 107, 1);
}

/deep/ .v-main {
  /* info */
  border: 3px solid rgba(137, 167, 202, 1);
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
