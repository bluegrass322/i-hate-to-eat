<template>
  <v-card color="pDark" flat tile outlined class="pa-0">
    <v-card-title class="base--text">
      <span class="text-subtitle-1">{{ basicInfo.name }}</span>
      <span class="text-subtitle-2">{{ basicInfo.subname }}</span>
      <span class="text-caption">{{ basicInfo.reference_amount * 100 }}g</span>
    </v-card-title>
    <v-card-text class="pa-0">
      <v-tabs background-color="pDark" color="base" dark center-active grow>
        <v-tab class="tabs">Macro</v-tab>
        <v-tab class="tabs">Vitamin</v-tab>
        <v-tab class="tabs-end">Mineral</v-tab>

        <v-tab-item class="tab-item">
          <div class="nutrients">
            <template v-for="m in macro">
              <nutrients-card
                :key="m.label"
                :label="m.label"
                :amount="m.amount"
                :unit="m.unit"
              />
            </template>
          </div>
          <div>※小数点以下は切り捨て</div>
        </v-tab-item>
        <v-tab-item class="tab-item">
          <div class="nutrients">
            <template v-for="v in vitamins">
              <nutrients-card
                :key="v.label"
                :label="v.label"
                :amount="v.amount"
                :unit="v.unit"
              />
            </template>
          </div>
        </v-tab-item>
        <v-tab-item class="tab-item">
          <div class="nutrients">
            <template v-for="m in minerals">
              <nutrients-card
                :key="m.label"
                :label="m.label"
                :amount="m.amount"
                :unit="m.unit"
              />
            </template>
          </div>
        </v-tab-item>
      </v-tabs>
    </v-card-text>
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex';
import NutrientsCard from '../parts/NutrientsCard';

export default {
  components: {
    NutrientsCard,
  },
  computed: {
    ...mapGetters('foodDetails', [
      'basicInfo',
      'macro',
      'vitamins',
      'minerals',
    ]),
  },
};
</script>

<style scoped>
.v-sheet.v-card:not(.v-sheet--outlined) {
  box-shadow: none;
}

.nutrients {
  display: flex;
  flex-wrap: wrap;
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
  background-color: #2c4c6b;
  border-top: solid 2px #f5f5f6;
  padding: 20px 10px;
}
</style>
