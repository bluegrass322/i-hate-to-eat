<template>
  <v-app-bar app bottom color="primary" fixed flat class="footer-menu">
    <footer-menu-items-after-login v-if="isLoggedIn" />
    <footer-menu-items-before-login v-else />
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex';
import FooterMenuItemsAfterLogin from './FooterMenuItemsAfterLogin';
import FooterMenuItemsBeforeLogin from './FooterMenuItemsBeforeLogin';

export default {
  components: {
    FooterMenuItemsAfterLogin,
    FooterMenuItemsBeforeLogin,
  },
  computed: {
    ...mapGetters('authUser', ['isLoggedIn']),
  },
};
</script>

<style scoped>
.footer-menu {
  padding: 0;
}
</style>
