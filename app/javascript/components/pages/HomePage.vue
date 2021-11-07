<template>
  <v-container class="container">
    <div class="date-and-savings base--text">
      <span class="date-text text-h5">
        {{ date }}
      </span>
      <span class="health-savings"> 健康貯金の総額 - ¥{{ savings }} </span>
    </div>
    <div v-if="chartLoaded" class="meal-record-charts">
      <div>本日の栄養摂取達成度</div>
      <radar-chart
        :chart-data="radarChart.data"
        :options="radarChart.options"
        class="achieve-chart"
      />
      <v-tabs
        background-color="pDark"
        color="base"
        dark
        center-active
        grow
        class="achieve-chart achieve-tabs"
      >
        <v-tab class="tabs">Vitamin</v-tab>
        <v-tab class="tabs-end">Mineral</v-tab>

        <v-tab-item class="tab-item">
          <bar-chart
            :chart-data="barChart.vitamins.data"
            :options="barChart.options"
            :height="barChart.height"
          />
        </v-tab-item>
        <v-tab-item class="tab-item">
          <bar-chart
            :chart-data="barChart.minerals.data"
            :options="barChart.options"
            :height="barChart.height"
          />
        </v-tab-item>
      </v-tabs>
    </div>
    <div v-else class="none-menus base--text">
      <span>{{ noneMessage }}</span>
    </div>
    <div>
      <p>ログイン状況</p>
      <p>ユーザーID: {{ userId }}</p>
      <p>ログイン: {{ isLoggedIn }}</p>
    </div>
  </v-container>
</template>

<script>
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';
import { mapState } from 'vuex';

import BarChart from '../parts/BarChart';
import RadarChart from '../parts/RadarChart';

export default {
  components: {
    BarChart,
    RadarChart,
  },
  data() {
    return {
      date: null,
      savings: null,
      chartLoaded: false,
      noneMessage: '本日は食事をとっていません',
      radarChart: {
        data: {
          labels: labelMacros,
          datasets: [
            {
              // dataキーはthis.$setで追加するため書かない
              backgroundColor: 'rgba(90, 120, 153, 0.5)',
              borderColor: colorBase['point1'],
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
              color: colorBase['point1'],
              lineWidth: 2,
            },
            // 目盛線
            gridLines: {
              color: colorBase['point1'],
              lineWidth: 2,
            },
            // 軸のラベル
            pointLabels: {
              fontSize: 12,
              fontColor: colorBase['point5'],
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
      barChart: {
        height: 900,
        vitamins: {
          data: {
            labels: labelVitamins,
            datasets: [
              JSON.parse(JSON.stringify(barChartAchv)),
              JSON.parse(JSON.stringify(barChartUnachv)),
            ],
          },
        },
        minerals: {
          data: {
            labels: labelMinerals,
            datasets: [
              JSON.parse(JSON.stringify(barChartAchv)),
              JSON.parse(JSON.stringify(barChartUnachv)),
            ],
          },
        },
        options: {
          legend: {
            display: false,
          },
          // responsive: true,
          scales: {
            xAxes: [
              {
                gridLines: {
                  color: colorBase['point3'],
                  zeroLineColor: colorBase['point5'],
                },
                stacked: true,
                ticks: {
                  fontColor: colorBase['point5'],
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
                  fontColor: colorBase['point5'],
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
    ...mapState({
      userId: (state) => state.authUser.userId,
      isLoggedIn: (state) => state.authUser.isLoggedIn,
    }),
  },
  mounted() {
    this.setDate();
    this.setData();
  },
  methods: {
    setDate() {
      dayjs.extend(utc);
      dayjs.extend(timezone);

      const today = dayjs();
      this.date = today.tz('Asia/Tokyo').format('YYYY.MM.DD');
    },
    setData() {
      this.axios
        .get('/api/v1/home')
        .then((res) => {
          console.log(res.status);
          const r = res.data;

          this.savings = r.savings;
          if (r.record) {
            this.$set(this.radarChart.data.datasets[0], 'data', r.record.macros);
            this.setBarChartVitamins(r.record.vitamins);
            this.setBarChartMinerals(r.record.minerals);
            this.chartLoaded = true;
          };
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
const labelMacros = ['エネルギー', 'タンパク質', '脂質', '炭水化物'];
// const labelMacros = ['Calorie', 'Protein', 'Fat', 'Carbo'];

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

// const labelMacros = ['Calorie', 'Protein', 'Fat', 'Carbo'];

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
const colorBase = {
  point1: 'rgba(245, 245, 246, 0.1)',
  point3: 'rgba(245, 245, 246, 0.3)',
  point5: 'rgba(245, 245, 246, 0.5)',
};

const barChartAchv = {
  label: '摂取達成率',
  // dataキーはthis.$setで追加するため書かない
  backgroundColor: 'rgba(90, 120, 153, 0.8)',
  borderColor: colorBase['point3'],
  borderWidth: 1,
  categoryPercentage: 0.7,
};
const barChartUnachv = {
  label: '摂取未達成率率',
  // dataキーはthis.$setで追加するため書かない
  backgroundColor: 'rgba(44, 76, 107, 0.8)',
  borderColor: colorBase['point3'],
  borderWidth: 1,
  categoryPercentage: 0.7,
};
</script>

<style scoped>
.achieve-chart {
  margin-bottom: 60px;
  max-width: 500px;
}

.container {
  margin: 10px, 0;
  padding: 0;
}

.date-and-savings {
  margin-top: 20px;
  height: 30;
  border-bottom: medium solid #f5f5f6;
}

.date-text {
  margin: 0 20px;
  padding: 0;
}

.none-message {
  margin: 30px 20px;
}

.meal-record-charts {
  padding: 15px 30px;
}

.achieve-tabs {
  border: 1px solid #f5f5f6;
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
  padding: 0 20px 0 20px;
}
</style>
