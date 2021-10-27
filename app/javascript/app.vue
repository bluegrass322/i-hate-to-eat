<template>
  <v-app class="app">
    <v-main>
      <common-header />
      <router-view />
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
</style>
