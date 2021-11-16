<template>
  <v-app-bar
    id="footer-menu"
    app
    bottom
    color="primary"
    fixed
    flat
    :height="height"
  >
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
    height() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 50;
        default:
          return 70;
      }
    },
  },
};
</script>

<style scoped>
#footer-menu {
  z-index: 999;
}

.v-app-bar >>> .v-toolbar__content {
  padding: 0;
  border: 2px solid #89a7ca;
  z-index: 999;
}
</style>
