<template>
  <div id="achv-tabs">
    <v-tabs
      background-color="back"
      color="accent"
      center-active
      dark
      grow
      class="ma-0 pa-0"
    >
      <v-tab class="tabs text-body-2">Macro</v-tab>
      <v-tab class="tabs text-body-2">Vitamin</v-tab>
      <v-tab class="tabs-end text-body-2">Mineral</v-tab>

      <v-tab-item class="tab-items">
        <div class="d-flex flex-wrap">
          <template v-for="mac in macro">
            <v-sheet :key="mac.key" color="#f5f5f6" :width="cardWidth" outlined>
              <v-card
                color="back"
                flat
                :height="cardHeight"
                tile
                class="d-flex flex-column justify-center align-center"
              >
                <v-card-text
                  class="
                    d-flex
                    flex-column
                    align-center
                    pa-0
                    accent--text
                    text-caption
                    pa-0
                  "
                >
                  <div class="text-subtitle-2 mb-2">
                    {{ mac.label }}
                  </div>
                  <div class="d-flex flex-column align-start">
                    <div>
                      Total: <span class="text-body-2">{{ mac.total }}</span
                      >{{ mac.unit }}
                    </div>
                    <div>
                      Achv: <span class="text-body-2">{{ mac.achv }}</span
                      >%
                    </div>
                  </div>
                </v-card-text>
              </v-card>
            </v-sheet>
          </template>
        </div>
      </v-tab-item>
      <v-tab-item class="tab-items">
        <div class="d-flex flex-wrap">
          <template v-for="vit in vitamins">
            <v-sheet :key="vit.key" color="#f5f5f6" :width="cardWidth" outlined>
              <v-card
                color="back"
                flat
                :height="cardHeight"
                tile
                class="d-flex flex-column justify-center align-center"
              >
                <v-card-text
                  class="
                    d-flex
                    flex-column
                    align-center
                    accent--text
                    text-caption
                    pa-0
                  "
                >
                  <div class="text-subtitle-2 mb-2">{{ vit.label }}</div>
                  <div class="d-flex flex-column align-start">
                    <div>
                      Total: <span class="text-subtitle-2">{{ vit.total }}</span
                      >{{ vit.unit }}
                    </div>
                    <div>
                      Achv: <span class="text-subtitle-2">{{ vit.achv }}</span
                      >%
                    </div>
                  </div>
                </v-card-text>
              </v-card>
            </v-sheet>
          </template>
        </div>
      </v-tab-item>
      <v-tab-item class="tab-items">
        <div class="d-flex flex-wrap">
          <template v-for="min in minerals">
            <v-sheet :key="min.key" color="#f5f5f6" :width="cardWidth" outlined>
              <v-card
                color="back"
                flat
                :height="cardHeight"
                tile
                class="d-flex flex-column justify-center align-center"
              >
                <v-card-text
                  class="
                    d-flex
                    flex-column
                    align-center
                    accent--text
                    text-caption
                    pa-0
                  "
                >
                  <div class="text-subtitle-2 mb-2">
                    {{ min.label }}
                  </div>
                  <div class="d-flex flex-column align-start">
                    <div>
                      Total: <span class="text-body-2">{{ min.total }}</span
                      >{{ min.unit }}
                    </div>
                    <div>
                      Achv: <span class="text-body-2">{{ min.achv }}</span
                      >%
                    </div>
                  </div>
                </v-card-text>
              </v-card>
            </v-sheet>
          </template>
        </div>
      </v-tab-item>
    </v-tabs>
    <div class="captions text-caption accent--text my-6 mx-2">
      <div class="mb-1">
        ※ マクロ栄養素の合計量（Total）は、計算結果の少数を切り捨てて表示。
      </div>
      <div class="mb-1">
        ※
        ビタミンおよびミネラルの合計量（Total）は、計算結果の少数第3位以下を切り捨てて表示。
      </div>
      <div>
        ※ 計算の過程で実際の栄養量との間に誤差が発生することがあります。
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      cardHeight: 100,
    };
  },
  computed: {
    ...mapGetters('nutrientsAchievements', ['macro', 'vitamins', 'minerals']),
    cardWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return '50%';
        case 'sm':
          return '25%';
        default:
          return '50%';
      }
    },
  },
};
</script>

<style scoped>
#achv-tabs {
  text-align: center;
}

.captions {
  margin: 0 auto;
  text-align: start;
  /* 2行目以降を1字下げ */
  padding-left: 1rem;
  text-indent: -1rem;
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

.v-tab {
  text-transform: none !important;
}
</style>
