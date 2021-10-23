<template>
  <v-card
    color="primary"
    flat
    tile
    height="60"
    width="115"
    class="nutrients-card"
  >
    <v-card-text class="pa-0 text-caption text-center base--text">
      <div class="font-weight-medium">
        {{ label }}
      </div>
      <div>
        {{ amount }} {{ unit }}
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      required: true,
      default: ''
    },
    amount: {
      // TODO: warnログ回避のために一時タイプを複数指定
      type: [String, Number],
      required: true,
      default: ''
    },
    unit: {
      type: String,
      required: true,
      default: 'mg'
    }
  }
};
</script>

<style scoped>
.nutrients-card {
  padding: 8px 8px;
}
</style>