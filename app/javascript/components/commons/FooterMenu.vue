<template>
  <v-app-bar
    app
    bottom
    color="primary"
    fixed
    flat
    :height="height"
    class="pa-0"
    style="border: 3px solid #89a7ca !important"
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
/deep/ .v-toolbar__content {
  padding: 0px !important;
}
</style>
