<template>
  <v-tabs background-color="primary" color="base" dark center-active>
    <v-tab>Vitamin</v-tab>
    <v-tab>Mineral</v-tab>

    <v-tab-item class="tab-item">
      <div class="nutrients">
        <template v-for="v in vitamins">
          <v-sheet :key="v.label" color="base">
            <v-card
              color="primary"
              flat
              tile
              height="60"
              min-width="98"
              max-width="120"
              class="nutrients-card"
            >
              <v-card-text class="pa-0 text-caption text-center base--text">
                <div class="font-weight-medium">
                  {{ v.label }}
                </div>
                <div>{{ v.amount }} {{ v.unit }}</div>
              </v-card-text>
            </v-card>
          </v-sheet>
        </template>
      </div>
    </v-tab-item>
    <v-tab-item class="tab-item">
      <div class="nutrients">
        <template v-for="m in minerals">
          <v-sheet :key="m.label" color="base">
            <v-card
              color="primary"
              flat
              tile
              height="60"
              min-width="98"
              max-width="120"
              class="nutrients-card"
            >
              <v-card-text class="pa-0 text-caption text-center base--text">
                <div class="font-weight-medium">
                  {{ m.label }}
                </div>
                <div>{{ m.amount }} {{ m.unit }}</div>
              </v-card-text>
            </v-card>
          </v-sheet>
        </template>
      </div>
    </v-tab-item>
  </v-tabs>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters('referenceIntakes', ['vitamins', 'minerals']),
  },
};
</script>

<style scoped>
.nutrients {
  display: flex;
  flex-wrap: wrap;
}

.nutrients-card {
  padding: 8px 8px;
}

.tab-item {
  background-color: #5a7899;
  border-top: solid 2px #f5f5f6;
  padding: 10px 10px;
}
</style>
