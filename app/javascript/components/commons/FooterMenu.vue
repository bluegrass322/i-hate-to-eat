<template>
  <v-app-bar app bottom color="primary" fixed flat class="footer-menu">
    <footer-menu-items-before-login />
  </v-app-bar>
</template>

<script>
import FooterMenuItemsBeforeLogin from '../parts/FooterMenuItemsBeforeLogin';

export default {
  components: {
    FooterMenuItemsBeforeLogin,
  },
};
</script>

<style scoped>
.footer-menu {
  padding: 0;
}
</style>
