<template>
  <v-toolbar color="primary" flat fixed height="70" tile>
    <flash-message class="flash-alert" />
    <div class="fix-item text-h5 base--text">I hate to Eat</div>
    <!-- <v-card
      flat
      width="300px"
      height="50px"
    >
      <span class="text-center text-h3">
        Ad
      </span>
    </v-card> -->
  </v-toolbar>
</template>

<script>
import FlashMessage from './FlashMessage';

export default {
  components: {
    FlashMessage,
  },
};
</script>

<style scoped>
.flash-alert {
  margin: 0;
  padding: 25px 15px;
}
</style>
