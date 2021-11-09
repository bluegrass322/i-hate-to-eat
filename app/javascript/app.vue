<template>
  <v-app>
    <common-header />
    <v-main>
      <v-container fill-height class="ma-0 pa-0">
        <router-view />
      </v-container>
    </v-main>
    <footer-menu />>
  </v-app>
</template>

<script>
import CommonHeader from './components/commons/CommonHeader';
import FooterMenu from './components/commons/FooterMenu';

export default {
  components: {
    CommonHeader,
    FooterMenu,
  },
};
</script>

<style scoped>
#app {
  /* secondary */
  background-color: rgba(44, 76, 107, 1.0);
}

/deep/ .v-main {
  /* info */
  border: 3px solid rgba(137, 167, 202, 1.0);
  box-sizing: border-box;
}
</style>
