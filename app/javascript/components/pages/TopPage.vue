<template>
  <v-container class="container">
    <v-row>
      <v-col cols="12" class="date">
        <span class="date-text text-h5 primary--text">
          {{ date }}
        </span>
      </v-col>
    </v-row>
    <v-row>
      <span>
        性別・年齢・身長・体重から1日に必要な最低限のエネルギー量である基礎代謝量が計算できます。
        また本日の食事内容をランダムに生成、それらの合計栄養素と、栄養毎の1日の摂取目標に対する達成度が確認できます。
      </span>
      <span>
        ブラウザバック、またはページをリロードするとフォームの入力内容はリセットされます
      </span>
    </v-row>
    <v-row>
      <v-col cols="12" md="4">
        <bmr-form @click="createTrialSuggestion()" />
      </v-col>

      <v-col v-if="suggestionsExists" cols="12" md="4">
        <div class="meal-menus">
          <template v-for="f in suggestions">
            <v-sheet :key="f.id" color="base" class="foods-card">
              <v-card
                flat
                tile
                color="primary"
                width="120"
                class="foods-card-contents"
              >
                <v-card-text class="pa-0 text-caption text-center base--text">
                  <div class="font-weight-medium">{{ f.name }}</div>
                  <div>{{ f.subname }}</div>
                  <div>{{ f.reference_amount * 100 }}g</div>
                </v-card-text>
              </v-card>
            </v-sheet>
          </template>
        </div>
        <div cols="12" md="6" class="pa-0">
          <nutrients-achievement />
        </div>
      </v-col>
    </v-row>
    <v-row class="base--text">
      <router-link to="/register">ユーザー登録してすべての機能を使用する</router-link>
    </v-row>
  </v-container>
</template>

<script>
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

import BmrForm from '../parts/BmrForm';
import NutrientsAchievement from '../parts/NutrientsAchievement';

export default {
  components: {
    BmrForm,
    NutrientsAchievement,
  },
  data() {
    return {
      date: '',
      suggestions: null,
      suggestionsExists: false,
    };
  },
  computed: {
    bmr: {
      get() {
        return this.$store.state.bmrParams.bmr;
      },
    },
  },
  mounted() {
    this.setDate();
  },
  methods: {
    createTrialSuggestion() {
      this.axios
        .post('/api/v1/trials', this.$store.state.bmrParams.user)
        .then((res) => {
          console.log(res.status);
          const r = res.data;

          this.$store.commit('bmrParams/updateBmr', r.bmr);
          this.suggestions = r.meals;
          this.suggestionsExists = true;

          this.$store.dispatch('nutrientsAchievements/setAttributes', {
            totals: r.total,
            achvs: r.achv,
          });
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    setDate() {
      dayjs.extend(utc);
      dayjs.extend(timezone);

      const today = dayjs();
      this.date = today.tz('Asia/Tokyo').format('YYYY.MM.DD');
    },
  },
};
</script>

<style scoped>
.container {
  margin: 10px, 0;
  padding: 0;
}

.date {
  margin-top: 20px;
  height: 30;
  border-bottom: medium solid #5a7899;
}

.date-text {
  margin: 0 20px;
  padding: 0;
}

.meal-menus {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.foods-card {
  border: 1px solid #f5f5f6;
}

.foods-card-contents {
  padding: 8px 8px;
}
</style>