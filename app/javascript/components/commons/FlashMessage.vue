<template>
  <v-alert v-show="message" dense height="70px" :type="type">
    {{ message }}
  </v-alert>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters('flashMessage', ['type', 'message']),
  },
};
</script>
