<template>
  <div class="ma-0 pa-0">
    <v-row class="mt-8 mx-0 pa-0">
      <v-col cols="12" class="ma-0 mb-10 pa-0 primary--text">
        <v-sheet
          color="primary"
          :width="siteDescWidth"
          class="site-title d-flex justify-center pt-2 pb-5 px-5"
        >
          <div class="d-flex flex-wrap flex-start align-end">
            <div class="d-flex align-end secondary--text mb-2">
              <div class="title-big">I</div>
              <div class="title-small">
                hate<br />
                to eat.
              </div>
            </div>

            <div class="title-desc secondary--text mt-4 mt-sm-0 ml-1 ml-sm-7">
              <div>
                食事は嫌い、けれど生きるためには<br />
                栄養を取らなければいけない。
              </div>
              <div class="mt-2">
                ならせめて食事について考える時間を<br />
                少しでも削減したいと思いませんか？
              </div>
              <div class="mt-3 ml-9">
                <router-link
                  to="/"
                  class="about-link d-flex flex-column align-start"
                >
                  サービスの概要はこちら
                  <div class="about-link arrow"></div>
                </router-link>
              </div>
            </div>
          </div>
        </v-sheet>
      </v-col>
    </v-row>

    <div class="trial mx-9 pa-0">
      <v-row class="text-body-1 accent--text">
        <!-- Step.1 ここから -->
        <v-col cols="12" md="4" class="trial-item pa-0">
          <div class="cutting-line font-weight-bold mb-2 pt-3 pb-1 pl-4">
            Step.1 基礎代謝量の算出
          </div>
          <div class="cutting-line ma-0 pt-3 pb-5 px-4">
            <div class="step-desc">
              以下のフォームから、1日に必要な最低限のエネルギー量<span
                class="text-body-2"
                >（基礎代謝量）</span
              >が計算できます。
            </div>
            <div class="text-caption mt-2">
              ※
              ブラウザバック、またはページをリロードするとフォームの入力内容はリセットされます。
            </div>
          </div>
          <bmr-form class="my-8 mx-7" @click="createTrialSuggestion()" />
        </v-col>
        <!-- Step.1 ここまで -->

        <!-- Step.2 ここから -->
        <v-col cols="12" md="4" class="trial-item mt-7 mt-md-0 pa-0">
          <div class="cutting-line font-weight-bold mb-2 pt-3 pb-1 pl-4">
            Step.2 食材の提案
          </div>
          <div class="cutting-line step-desc ma-0 pt-3 pb-5 px-4">
            栄養価の高いおすすめの食材をランダムにレコメンド。食材の詳細な栄養情報も確認できます。
          </div>

          <template v-if="suggestionsExists">
            <food-card :suggestions="suggestions" />
          </template>
          <!-- 提案未作成時に表示 -->
          <div
            v-else
            class="
              suggestion-placeholder
              d-flex
              justify-center
              align-center
              text-h6
              info--text
              py-4
              px-7
            "
          >
            <div>未生成</div>
          </div>
        </v-col>
        <!-- Step.2 ここまで -->

        <!-- Step.3 ここから -->
        <v-col cols="12" md="4" class="trial-item mt-7 mt-md-0 pa-0">
          <div class="cutting-line font-weight-bold mb-2 pt-3 pb-1 pl-4">
            Step.3
          </div>
          <div class="cutting-line step-desc ma-0 pt-3 pb-5 px-4">
            Step.2
            でレコメンドした食材から摂取できる栄養素ごとの合計量と、1日の摂取目標に対する達成度が確認できます。
          </div>
          <nutrients-achievement />
        </v-col>
        <!-- Step.3 ここまで -->
      </v-row>

      <v-row class="my-13">
        <v-btn
          to="/register"
          color="accent"
          text
          tile
          height="20"
          :min-width="minBtnWidth"
          class="
            register-link
            text-caption text-sm-body-1
            ma-0
            py-5 py-sm-7
            flex-grow-1 flex-shrink-0
          "
        >
          ユーザー登録してすべての機能を使用する
        </v-btn>
      </v-row>
    </div>
  </div>
</template>

<script>
import BmrForm from '../parts/BmrForm';
import FoodCard from '../parts/FoodCard';
import NutrientsAchievement from '../parts/NutrientsAchievement';

export default {
  components: {
    BmrForm,
    FoodCard,
    NutrientsAchievement,
  },
  data() {
    return {
      suggestions: null,
      suggestionsExists: false,
      minBtnWidth: '40',
    };
  },
  computed: {
    bmr: {
      get() {
        return this.$store.state.bmrParams.bmr;
      },
    },
    siteDescHeight() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return 200;
        default:
          return 350;
      }
    },
    siteDescWidth() {
      return this.$vuetify.breakpoint.width;
    },
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
  },
};
</script>

<style scoped>
.about-link {
  color: rgba(44, 76, 107, 1);
  text-decoration: none;
}

.about-link.arrow {
  position: relative;
  top: -5px;
  left: -5px;
  width: 180px;
  height: 8px;
  border-bottom: 2px solid rgba(44, 76, 107, 1);
  border-right: 2px solid rgba(44, 76, 107, 1);
  transform: skew(45deg);
}

.foods-card {
  border: 1px solid rgba(245, 245, 246, 1);
}

.foods-card-contents {
  padding: 8px 8px;
}

.cutting-line {
  border-bottom: 1px dashed rgba(245, 245, 246, 1);
}

.register-link {
  color: rgba(245, 245, 246, 1);
  border: 1px solid rgba(245, 245, 246, 1);
}

.site-title {
  font-family: 'Zen Antique', serif;
  width: 100%;
}

.step-desc {
  text-indent: 1rem;
}

.suggestion-placeholder {
  height: 150px;
}

.title-big {
  font-size: 10.5rem;
  line-height: 9.1rem;
}

.title-desc {
  font-size: 0.9rem;
}

.title-small {
  font-size: 3.6rem;
  line-height: 3rem;
  margin-bottom: 1px;
  margin-left: 5px;
}

.trial-item {
  border: 1px solid rgba(245, 245, 246, 1);
}
</style>
