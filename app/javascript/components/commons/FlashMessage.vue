<template>
  <v-alert
    v-if="message"
    elevation="0"
    dense
    height="70"
    :type="type"
    :width="alertWidth"
    class="alert d-flex justify-center align-center text-subtitle-2 ma-0 flex-grow-1"
  >
    {{ message }}
  </v-alert>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters('flashMessage', ['type', 'message']),
    alertWidth() {
      return this.$vuetify.breakpoint.width;
    },
  },
};
</script>
