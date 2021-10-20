<template>
  <v-tabs background-color="primary" color="base" dark center-active grow>
    <v-tab class="tabs">Macro</v-tab>
    <v-tab class="tabs">Vitamin</v-tab>
    <v-tab class="tabs-end">Mineral</v-tab>

    <v-tab-item class="tab-item">
      <template
        v-for="m in macro"
      >
        <v-sheet :key="m.key" color="base" class="nutrients-card">
          <v-card
            color="primary"
            flat
            tile
            height="80"
            width="130"
            class="nutrients-card-contents"
          >
            <v-card-text class="pa-0 text-caption text-left base--text">
              <div class="font-weight-medium">{{ m.label }}</div>
              <div>Total:<span class="text-body-2">{{ m.total }}</span>{{ m.unit }}</div>
              <div>Achv:<span class="text-body-2">{{ m.achv }}</span>%</div>
            </v-card-text>
          </v-card>
        </v-sheet>
      </template>
    </v-tab-item>
    <v-tab-item class="tab-item">
      <template
        v-for="v in vitamins"
      >
        <v-sheet :key="v.key" class="nutrients-card">
          <v-card
            color="primary"
            flat
            tile
            height="80"
            width="130"
            class="nutrients-card-contents"
          >
            <v-card-text class="pa-0 text-caption text-left base--text">
              <div class="font-weight-medium">{{ v.label }}</div>
              <div>Total:<span class="text-body-2">{{ v.total }}</span>{{ v.unit }}</div>
              <div>Achv:<span class="text-body-2">{{ v.achv }}</span>%</div>
            </v-card-text>
          </v-card>
        </v-sheet>
      </template>
    </v-tab-item>
    <v-tab-item class="tab-item">
      <template
        v-for="m in minerals"
      >
        <v-sheet :key="m.key" class="nutrients-card">
          <v-card
            color="primary"
            flat
            tile
            height="80"
            width="130"
            class="nutrients-card-contents"
          >
            <v-card-text class="pa-0 text-caption text-left base--text">
              <div class="font-weight-medium">{{ m.label }}</div>
              <div>Total:<span class="text-body-2">{{ m.total }}</span>{{ m.unit }}</div>
              <div>Achv:<span class="text-body-2">{{ m.achv }}</span>%</div>
            </v-card-text>
          </v-card>
        </v-sheet>
      </template>
    </v-tab-item>
  </v-tabs>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters('nutrientsAchievements', [
      'macro',
      'vitamins',
      'minerals'
    ])
  }
};
</script>

<style scoped>
.nutrients-card {
  border: 1px solid #f5f5f6;
}

.nutrients-card-contents {
  padding: 8px 8px;
}

.tabs {
  border-right: 1px solid #f5f5f6;
  border-top: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
}

.tabs-end {
  border-top: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
}

.tab-item {
  background-color: #5a7899;
  padding: 20px 15px 40px 15px;
  display: flex;
  flex-wrap: wrap;
}
</style>
