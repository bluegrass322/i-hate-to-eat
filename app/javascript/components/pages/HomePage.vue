<template>
  <div id="home-items" class="my-9 pa-0">
    <v-row class="health-savings mt-5 pa-0">
      <v-col cols="12" class="ma-0 pa-0">
        <div class="d-flex flex-column align-start accent--text ma-0 mr-4 pa-0">
          <div class="line-first d-flex flex-column justify-end align-end ma-0">
            <div class="text-caption pr-2">あなたの健康貯金</div>
            <div class="underline underline-left underline-first" />
          </div>
          <div
            class="line-second d-flex flex-column justify-end align-end ma-0"
          >
            <div class="text-h6 pr-3">
              <span class="text-subtitle-1">¥</span>
              <span class="font-weight-medium">{{ savings }}</span>
            </div>
            <div class="underline underline-left underline-second" />
          </div>
        </div>
      </v-col>
    </v-row>

    <v-row
      v-if="chartLoaded"
      class="d-flex flex-wrap justify-center align-start my-16 mx-5"
    >
      <v-col
        cols="12"
        md="6"
        class="d-flex flex-column justify-center align-center ma-0 pa-0"
      >
        <div class="d-flex flex-column align-start">
          <div
            class="
              item-title
              d-flex
              justify-start
              align-end
              accent--text
              ma-0
              pa-0
              mb-5 mb-md-7
            "
          >
            <div class="d-flex align-end">
              <date-card class="date-card text-subtitle-1 text-md-h6 mr-1" />
              <span class="text-body-2 text-md-body-1">の栄養摂取達成度</span>
            </div>
            <div class="underline underline-right" />
          </div>

          <div
            class="
              cahrt-back
              radar-title
              d-flex
              justify-center
              align-center
              text-boty-2
            "
          >
            <div>Macro</div>
          </div>
          <radar-chart
            :chart-data="radarChart.data"
            :options="radarChart.options"
            :style="radarStyle"
            class="charts cahrt-back ma-0 pa-5"
          />
        </div>
      </v-col>

      <v-col
        cols="12"
        md="6"
        class="
          cahrt-back
          charts
          d-flex
          justify-center
          ml-md-7
          mt-7 mt-md-14
          pa-0
        "
      >
        <v-tabs background-color="back" color="accent" dark center-active grow>
          <v-tab class="tabs cahrt-back text-boty-2">Vitamin</v-tab>
          <v-tab class="tabs-end cahrt-back text-boty-2">Mineral</v-tab>

          <v-tab-item class="tab-items ma-0 pa-0">
            <bar-chart
              :chart-data="barChart.vitamins.data"
              :options="barChart.options"
              class="cahrt-back pt-5 pb-3 pl-3 pr-2"
            />
          </v-tab-item>
          <v-tab-item class="tab-items ma-0 pa-0">
            <bar-chart
              :chart-data="barChart.minerals.data"
              :options="barChart.options"
              class="cahrt-back pt-5 pb-3 pl-3 pr-2"
            />
          </v-tab-item>
        </v-tabs>
      </v-col>
    </v-row>
    <v-row v-else>
      <v-col cols="12" class="d-flex justify-center align-center">
        <div class="none-message">{{ noneMessage }}</div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import BarChart from '../parts/BarChart';
import DateCard from '../parts/DateCard';
import RadarChart from '../parts/RadarChart';

export default {
  components: {
    BarChart,
    DateCard,
    RadarChart,
  },
  data() {
    return {
      savings: '0,000',
      chartLoaded: false,
      noneMessage: '本日は食事をとっていません',
      // 以下、チャート用データ
      // レーダーチャートここから
      radarChart: {
        data: {
          labels: labelMacros,
          datasets: [
            {
              // dataキーはthis.$setで追加するため書かない
              backgroundColor: colorPrimary['alpha8'],
              borderColor: colorAccent['alpha3'],
              borderWidth: 1,
              borderCapStyle: 'butt',
              borderJoinStyle: 'miter',
              pointRadius: 0,
            },
          ],
        },
        options: {
          legend: {
            display: false,
          },
          responsive: true,
          scale: {
            // 放射軸
            angleLines: {
              color: colorAccent['alpha3'],
              lineWidth: 1,
            },
            // 目盛線
            gridLines: {
              color: colorAccent['alpha3'],
              lineWidth: 1,
            },
            // 軸のラベル
            pointLabels: {
              fontSize: 12,
              fontColor: colorAccent['alpha10'],
            },
            // 目盛
            ticks: {
              display: false,
              max: 100,
              min: 0,
              stepSize: 20,
            },
          },
        },
      },
      // レーダーチャートここまで

      // バーチャートここから
      barChart: {
        height: 900,
        vitamins: {
          data: {
            labels: labelVitamins,
            datasets: vitaminDatasets,
          },
        },
        minerals: {
          data: {
            labels: labelMinerals,
            datasets: mineralDatasets,
          },
        },
        // オプションはvitamin, mineralで共用
        options: {
          legend: {
            display: false,
          },
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            xAxes: [
              {
                gridLines: {
                  color: colorAccent['alpha3'],
                  zeroLineColor: colorAccent['alpha5'],
                },
                stacked: true,
                ticks: {
                  fontColor: colorAccent['alpha5'],
                  max: 100,
                  min: 0,
                  stepSize: 20,
                },
              },
            ],
            yAxes: [
              {
                gridLines: {
                  display: false,
                },
                stacked: true,
                ticks: {
                  fontColor: colorAccent['alpha10'],
                  fontSize: 12,
                },
              },
            ],
          },
        },
      },
    };
  },
  computed: {
    radarStyle() {
      return {
        position: 'relative',
        width: `${this.$vuetify.breakpoint.width * 0.85}px`,
      };
    },
    thirdLineWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 'width: 70%;';
        case 'sm':
        case 'md':
        case 'lg':
        case 'xl':
          return 'width: 90%;';
        default:
          return 'max-width: 350px;';
      }
    },
  },
  mounted() {
    this.setData();
  },
  methods: {
    setData() {
      this.axios
        .get('/api/v1/home')
        .then((res) => {
          console.log(res.status);
          const r = res.data;

          this.savings = r.savings;

          // 普通にプロパティを追加するのではVueが変更を検知できずリアクティブにならないためVue.setを使用
          if (r.record) {
            this.$set(
              this.radarChart.data.datasets[0],
              'data',
              r.record.macros
            );
            this.setBarChartVitamins(r.record.vitamins);
            this.setBarChartMinerals(r.record.minerals);
            this.chartLoaded = true;
          }
        })
        .catch((e) => {
          console.log(e.response.status);
        });
    },
    setBarChartVitamins(value) {
      this.$set(this.barChart.vitamins.data.datasets[0], 'data', value.achv);
      this.$set(this.barChart.vitamins.data.datasets[1], 'data', value.unachv);
    },
    setBarChartMinerals(value) {
      this.$set(this.barChart.minerals.data.datasets[0], 'data', value.achv);
      this.$set(this.barChart.minerals.data.datasets[1], 'data', value.unachv);
    },
  },
};

// 以下変数定義

// チャートのラベル
const labelMacros = ['kcal', 'Protein', 'Fat', 'Carbo'];

const labelVitamins = [
  'ビタミンA',
  'ビタミンD',
  'ビタミンE',
  'ビタミンK',
  'ビタミンB1',
  'ビタミンB2',
  'ナイアシン',
  'ビタミンB6',
  'ビタミンB12',
  '葉酸',
  'パントテン酸',
  'ビオチン',
  'ビタミンC',
];

const labelMinerals = [
  'カリウム',
  'カルシウム',
  'マグネシウム',
  'リン',
  '鉄',
  '亜鉛',
  '銅',
  'マンガン',
  'ヨウ素',
  'セレン',
  'クロム',
  'モリブデン',
];

// const labelMacros = ['エネルギー', 'タンパク質', '脂質', '炭水化物'];

// const labelVitamins = [
//   'Vitamin A', 'Vitamin D', 'Vitamin E', 'Vitamin K',
//   'Vitamin B1', 'Vitamin B2', 'Niacin', 'Vitamin B6',
//   'Vitamin B12', 'Folate', 'Pantothenic Acid',
//   'Biotin', 'Vitamin C'
// ];

// const labelMinerals = [
//   'Potassium', 'Calcium', 'Magnesium', 'Phosphorus',
//   'Iron', 'Zinc', 'Copper', 'Manganese', 'Iodine',
//   'Selenium', 'Chromium', 'Molybdenum'
// ];

// チャートで使用するカラー
const colorAccent = {
  alpha1: 'rgba(245, 245, 246, 0.1)',
  alpha3: 'rgba(245, 245, 246, 0.3)',
  alpha5: 'rgba(245, 245, 246, 0.5)',
  alpha10: 'rgba(245, 245, 246, 1)',
};

const colorPrimary = {
  alpha8: 'rgba(44, 76, 107, 0.8)',
};

// データセット
const barChartAchv = {
  label: '摂取達成率',
  // dataキーはthis.$setで追加するため書かない
  backgroundColor: colorPrimary['alpha8'],
  borderColor: colorAccent['alpha3'],
  borderWidth: 1,
  categoryPercentage: 0.7,
};

const barChartUnachv = {
  label: '摂取未達成率率',
  // dataキーはthis.$setで追加するため書かない
  backgroundColor: colorAccent['alpha1'],
  borderColor: colorAccent['alpha3'],
  borderWidth: 1,
  categoryPercentage: 0.7,
};

// vitaminとmineralで同一オブジェクトを元にするためシャローコピー
const vitaminDatasets = [
  Object.assign({}, barChartAchv),
  Object.assign({}, barChartUnachv),
];

const mineralDatasets = [
  Object.assign({}, barChartAchv),
  Object.assign({}, barChartUnachv),
];
</script>

<style scoped>
#home-items {
  width: 100%;
}

.chart-title {
  border: 1px solid #f5f5f6;
}

.date-card {
  position: relative;
  top: 3px;
}
/* .tabs {
  height: 100%;
} */

.health-savings {
  margin-left: 2px;
  margin-right: 2px;
  position: fixed;
  top: 0%;
  left: 0;
  width: 100%;
  z-index: 99;
}

.line-second {
  position: relative;
  top: -26px;
  left: 70px;
}

.line-third {
  position: relative;
  top: -10px;
  right: 0;
}

.none-message {
  color: rgba(245, 245, 246, 0.6);
}

.charts {
  max-width: 400px;
}

.cahrt-back {
  border: 1px solid rgba(245, 245, 246, 1);
  /* background-color: rgba(44, 76, 107, 0.8); */
}

.radar-title {
  color: rgba(245, 245, 246, 0.9);
  /* margin-bottom: 3px; */
  max-width: 200px;
  height: 48px;
  width: 50%;
}

.tabs {
  /* border-bottom: 3px solid rgba(55, 56, 56, 1);
  border-right: 2px solid rgba(55, 56, 56, 1); */
  border: 1px solid #f5f5f6;
}

.tabs-end {
  border-right: 1px solid #f5f5f6;
  border-top: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
  /* border-bottom: 3px solid rgba(55, 56, 56, 1);
  border-left: 2px solid rgba(55, 56, 56, 1); */
}

.tab-items {
  background-color: rgb(55, 56, 56);
  /* border-top: solid 2px #f5f5f6; */
}

.underline {
  border-bottom: 1px solid rgb(245, 245, 246);
  position: relative;
  top: -6px;
}

.underline.underline-left {
  margin-right: 5px;
  width: 15px;
}

.underline.underline-left.under-line-title {
  width: 15px;
}

.underline.underline-right {
  margin-left: 5px;
  width: 15px;
}

.underline.underline-first {
  margin-top: 4px;
  position: relative;
  top: -5px;
  width: 130px;
}

.underline.underline-second {
  margin-top: 4px;
  position: relative;
  top: -5px;
  width: 170px;
}

.underline.underline-third {
  width: 100px;
}

.v-tab {
  text-transform: none !important;
}
</style>
