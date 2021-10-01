<template>
  <v-app-bar app bottom color="primary" fixed flat>
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
