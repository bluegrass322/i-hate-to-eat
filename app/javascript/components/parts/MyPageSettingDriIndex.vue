<template>
  <div id="dri-tabs">
    <v-tabs
      background-color="back"
      color="accent"
      center-active
      dark
      grow
      class="ma-0 pa-0"
    >
      <v-tab class="tabs text-body-2">Vitamin</v-tab>
      <v-tab class="tabs-end text-body-2">Mineral</v-tab>

      <v-tab-item class="tab-items">
        <div class="d-flex flex-wrap">
          <template v-for="v in vitamins">
            <v-sheet :key="v.label" color="#f5f5f6" :width="cardWidth" outlined>
              <v-card
                color="back"
                flat
                :height="cardHeight"
                tile
                class="d-flex flex-column justify-center align-center"
              >
                <v-card-text class="pa-0 accent--text text-caption">
                  <div class="text-body-2 font-weight-medium">
                    {{ v.label }}
                  </div>
                  <div>{{ v.amount }} {{ v.unit }}</div>
                </v-card-text>
              </v-card>
            </v-sheet>
          </template>
        </div>
      </v-tab-item>
      <v-tab-item class="tab-items">
        <div class="d-flex flex-wrap">
          <template v-for="m in minerals">
            <v-sheet :key="m.label" color="#f5f5f6" :width="cardWidth" outlined>
              <v-card
                color="back"
                flat
                :height="cardHeight"
                tile
                class="d-flex flex-column justify-center align-center"
              >
                <v-card-text class="pa-0 accent--text text-caption">
                  <div class="text-body-2 font-weight-medium">
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
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      cardHeight: 90,
    };
  },
  computed: {
    ...mapGetters('referenceIntakes', ['vitamins', 'minerals']),
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        // case 'xs':
        //   return '50%';
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

<style scoped>
.v-tab {
  text-transform: none !important;
}

#dri-tabs {
  text-align: center;
}

.nutrients {
  display: flex;
  flex-wrap: wrap;
}

.tabs {
  border-top: 1px solid #f5f5f6;
  border-left: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
}

.tabs-end {
  border-top: 1px solid #f5f5f6;
  border-left: 1px solid #f5f5f6;
  border-right: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
}

.tab-items {
  background-color: rgb(55, 56, 56);
}
</style>
