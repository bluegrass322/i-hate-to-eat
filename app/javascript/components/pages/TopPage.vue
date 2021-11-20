<template>
  <div class="ma-0 pa-0">
    <v-row
      class="title-row d-felx justify-center ma-0 pt-10 pb-16 px-7"
      :style="titleRow"
    >
      <v-col
        cols="12"
        class="
          title-col
          d-flex
          flex-column-reverse flex-sm-row
          justify-center
          align-center
          ma-0
          pa-0
        "
        :style="titleCol"
      >
        <div
          class="d-flex flex-row flex-sm-column align-end align-sm-center"
          :style="titleGroup"
        >
          <div class="d-flex align-end info--text">
            <div class="site-title" :style="titleBig">Eat</div>
            <div class="site-title" :style="titleSmall">
              this<br />
              for now!
            </div>
          </div>
          <div class="ml-4 ml-sm-0 mt-sm-4">
            <router-link
              to="/"
              class="about-link d-flex flex-column align-center"
              style="text-decoration: line-through"
            >
              <span class="link-text" :style="aboutLinkText"
                >about service</span
              >
              <div :style="aboutLinkArrow"></div>
            </router-link>
          </div>
        </div>

        <div
          class="
            d-flex
            flex-md-column-reverse
            justify-start
            text-caption text-sm-subtitle-2
            info--text
            mt-0 mt-md-5
          "
          :style="titleDescGroup"
        >
          <div
            class="site-title site-title-copy mt-1 mt-md-0"
            :style="titleDesc"
          >
            <ruby>"Eat this for now !"<rt>とりあえずこれ食っとけ</rt></ruby>
          </div>
          <div class="site-title mb-md-5 ml-5 ml-md-0" :style="titleDesc">
            そんな悩みを持つ人のための、食材提案 ＆ リマインドサービス。
          </div>
          <div class="site-title mb-md-5 ml-5 ml-md-0" :style="titleDesc">
            食事について考える時間を、ほんの少しだけでも削減したいけれど<br />
            生きるためには栄養は摂らなければならない。<br />
          </div>
          <div class="site-title mb-md-3 ml-3 ml-md-0" :style="titleDesc">
            食事が嫌い、何を食べるか考えることすら面倒くさい。<br />
            というかそもそも、食事を取ることを忘れてしまう。
          </div>
        </div>
      </v-col>
    </v-row>

    <!-- sm以下の時のみ表示 -->
    <v-row
      v-if="$vuetify.breakpoint.xsOnly"
      class="d-felx justify-center pr-7 pl-8"
    >
      <v-col
        cols="12"
        class="trial-arrow-group d-flex justify-start align-start"
      >
        <div class="arrow-vertical"></div>
        <div class="link-text link-trial">trial</div>
      </v-col>
    </v-row>

    <div id="trial-top" class="trial mx-9 pa-0">
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
              accent--text
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
    // style系
    aboutLinkArrow() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            width: '110px',
            height: '5px',
            borderBottom: '1px solid rgb(137, 167, 202)',
            borderRight: '2px solid rgb(137, 167, 202)',
            transform: 'skew(45deg)',
          };
        default:
          return {
            width: '150px',
            height: '8px',
            borderBottom: '2px solid rgb(137, 167, 202)',
            borderRight: '2px solid rgb(137, 167, 202)',
            transform: 'skew(45deg)',
          };
      }
    },
    aboutLinkText() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            fontSize: '0.8rem',
            lineHeight: '0.8rem',
            position: 'relative',
            top: '1px',
            left: '-5px',
          };
        default:
          return {
            fontSize: '1rem',
            lineHeight: '1rem',
            position: 'relative',
            top: '2px',
            left: '-3px',
          };
      }
    },
    titleRow() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
        case 'sm':
          return {
            height: `${this.$vuetify.breakpoint.height * 0.98}px`,
          };
        default:
          return {
            height: `${this.$vuetify.breakpoint.height * 0.5}px`,
          };
      }
    },
    titleCol() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            maxWidth: '400px',
            height: '100%',
            width: '100%',
          };
        default:
          return {
            maxWidth: '900px',
            height: '100%',
            width: '100%',
          };
      }
    },
    titleGroup() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            alignSelf: 'start',
            marginRight: 'auto',
          };
        default:
          return { marginRight: '80px' };
      }
    },
    titleDescGroup() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            alignSelf: 'end',
            marginBottom: 'auto',
          };
        default:
          return null;
      }
    },
    titleBig() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            fontSize: '3rem',
            lineHeight: '3rem',
            position: 'relative',
            top: '2px',
          };
        default:
          return {
            fontSize: '5rem',
            lineHeight: '5rem',
            position: 'relative',
            top: '3px',
          };
      }
    },
    titleSmall() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
          return {
            fontSize: '1.1rem',
            lineHeight: '1.1rem',
            marginLeft: '7px',
          };
        default:
          return {
            fontSize: '1.8rem',
            lineHeight: '1.8rem',
            marginLeft: '10px',
          };
      }
    },
    titleDesc() {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs':
        case 'sm':
          return {
            writingMode: 'vertical-rl',
          };
        default:
          return {};
      }
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
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+JP&family=Zen+Antique&display=swap');

.about-link,
.link-trial {
  color: rgba(137, 167, 202, 1);
  text-decoration: none;
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

.link-trial {
  font-size: 0.9rem;
  transform: rotate(90deg);
  line-height: 0.8rem;
}

.register-link {
  color: rgba(245, 245, 246, 1);
  border: 1px solid rgba(245, 245, 246, 1);
}

.site-title,
.link-text {
  font-family: 'Zen Antique', serif, 'Noto Serif JP', serif;
}

.site-title-copy {
  font-size: 1.3rem;
}

.step-desc {
  text-indent: 1rem;
}

.suggestion-placeholder {
  height: 150px;
}

.text-vertical {
  writing-mode: vertical-rl;
}

.title-big {
  font-size: 10.5rem;
  line-height: 9.1rem;
}

.title-desc {
  font-size: 0.9rem;
}

.trial-arrow-group {
  max-width: 400px;
  position: relative;
  top: -45px;
  left: 0;
}

.arrow-vertical {
  position: relative;
  top: -12px;
  left: 10px;
  height: 100px;
  width: 5px;
  border-left: 1px solid rgba(137, 167, 202, 1);
  border-bottom: 2px solid rgba(137, 167, 202, 1);
  transform: skewY(-45deg);
}

.trial-item {
  border: 1px solid rgba(245, 245, 246, 1);
}
</style>
