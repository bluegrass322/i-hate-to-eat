<template>
  <v-sheet color="#f5f5f6" outlined :width="cardWidth">
    <v-card color="back" flat tile height="70" class="d-flex align-center">
      <v-card-text class="card-text pa-0 accent--text">
        <div class="text-item d-flex flex-column justify-center align-center">
          <div class="text-subtitle-2 font-weight-medium">
            {{ label }}
          </div>
          <div class="text-body-2">{{ amount }} {{ unit }}</div>
        </div>
      </v-card-text>
    </v-card>
  </v-sheet>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true,
      default: '',
    },
    amount: {
      // TODO: warnログ回避のために一時タイプを複数指定
      type: [String, Number],
      required: true,
      default: '',
    },
    unit: {
      type: String,
      required: true,
      default: 'mg',
    },
  },
  computed: {
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'lg':
        case 'xl':
          return '25%';
        default:
          return '50%';
      }
    },
  },
};
</script>

<style scoped></style>
