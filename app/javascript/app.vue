<template>
  <v-app>
    <common-header />
    <v-main>
      <v-container class="ma-0 pa-0">
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
  background-color: #2c4c6b;
}

/deep/ .v-main {
  border: 3px solid #89a7ca;
  box-sizing: border-box;
}
</style>
