<template>
  <v-card color="back" flat tile :max-height="cardHeight" class="detail-card ma-0 pa-0">
    <v-card-title class="d-flex align-end accent--text my-3">
      <div class="d-flex">
        <div class="text-subtitle-2">{{ basicInfo.name }}</div>
        <div class="text-caption font-weight-midium ml-1">
          {{ basicInfo.subname }}
        </div>
      </div>
      <div class="text-body-2 ml-2">
        {{ basicInfo.reference_amount * 100 }}g
      </div>
    </v-card-title>

    <v-card-text class="ma-0 pa-0">
      <v-tabs
        background-color="pDark"
        color="base"
        dark
        center-active
        grow
        class="ma-0 pa-0"
      >
        <v-tab class="tabs">Macro</v-tab>
        <v-tab class="tabs">Vitamin</v-tab>
        <v-tab class="tabs-end">Mineral</v-tab>

        <v-tab-item class="tab-items ma-0 pa-0">
          <div class="d-flex flex-wrap align-center ma-0 pa-0">
            <template v-for="m in macro">
              <nutrients-card
                :key="m.label"
                :label="m.label"
                :amount="m.amount"
                :unit="m.unit"
              />
            </template>
          </div>
        </v-tab-item>
        <v-tab-item class="tab-items">
          <div class="d-flex flex-wrap align-center">
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
        <v-tab-item class="tab-items">
          <div class="d-flex flex-wrap align-center">
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
    cardHeight() {
      return this.$vuetify.breakpoint.height * 0.75;
    },
  },
};
</script>

<style scoped>
.tabs {
  border-top: 1px solid rgb(245, 245, 246);
  border-left: 1px solid rgb(245, 245, 246);
  border-bottom: 1px solid rgb(245, 245, 246);
}

.tabs-end {
  border-top: 1px solid rgb(245, 245, 246);
  border-left: 1px solid rgb(245, 245, 246);
  border-right: 1px solid rgb(245, 245, 246);
  border-bottom: 1px solid rgb(245, 245, 246);
}

.tab-items {
  background-color: rgb(55, 56, 56);
}

.v-tab {
  background-color: rgb(55, 56, 56);
  text-transform: none !important;
}

.v-sheet.v-card.detail-card {
  border: 1px solid rgb(245, 245, 246) !important;
  border-radius: 3px !important;
  box-sizing: border-box;
}
</style>
