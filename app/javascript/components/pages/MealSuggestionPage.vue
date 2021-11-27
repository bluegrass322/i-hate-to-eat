<template>
  <div id="bmr-and-dri">
    <v-row class="my-12 mx-9">
      <!-- 食材一覧 ここから -->
      <v-col
        cols="12"
        md="5"
        class="
          mypage-items
          d-flex
          flex-column
          align-center
          mb-15 mb-md-0
          mx-0 mx-md-auto
          pa-0
          flex-grow-1 flex-shrink-1
        "
      >
        <div :style="contentWidth">
          <div class="item-desc">
            <div
              class="
                desc-content desc-left
                d-flex
                flex-wrap flex-column
                align-start
              "
            >
              <div
                class="item-title d-flex align-end accent--text ma-0 pa-0 mb-5"
              >
                本日の食材
                <div class="under-line line-right-long" />
              </div>
            </div>
          </div>

          <template v-if="suggestionsExists" class="ma-0 pa-0">
            <div style="width: 100%">
              <food-card :suggestions="suggestions" />
            </div>
            <div class="confirm-group d-flex flex-column align-center mt-13">
              <div class="d-flex align-end text-subtitle-2 mb-10">
                食べてみますか？
                <div class="under-line line-right" />
              </div>
              <div class="d-flex justify-center align-center">
                <v-btn
                  color="accent"
                  :height="btnHeihgt"
                  small
                  tile
                  outlined
                  :width="btnWidth"
                  class="confirm-btn mx-5 px-5 flex-grow-1"
                  @click.stop="destroySuggestions()"
                >
                  No
                </v-btn>
                <v-btn
                  color="accent"
                  :height="btnHeihgt"
                  small
                  tile
                  outlined
                  :width="btnWidth"
                  class="confirm-btn mx-5 px-5 flex-grow-1"
                  @click.stop="createMealRecord()"
                >
                  Yes
                </v-btn>
              </div>
            </div>
          </template>
          <div
            v-else
            class="
              d-flex
              justify-center
              align-center
              text-body-2
              accent--text
              my-15
            "
          >
            <div class="suggestions-placeholder d-flex align-center">
              <div class="under-line line-vertical" />
              <span class="ml-1">{{ noneMessage }}</span>
            </div>
          </div>
          <div class="d-flex justify-center align-center my-5">
            <v-btn
              color="accent"
              :height="btnHeihgt"
              small
              tile
              outlined
              :width="btnWidthLarge"
              class="confirm-btn mx-5 px-5"
              @click.stop="reloadSuggestions()"
            >
              Recreate
            </v-btn>
          </div>
        </div>
      </v-col>
      <!-- 食材一覧 ここまで -->

      <!-- DRI一覧 ここから -->
      <v-col
        cols="12"
        md="7"
        class="
          mypage-items
          d-flex
          flex-column
          align-center
          ma-0
          mt-16 mt-md-0
          mx-0 mx-md-auto
          pa-0
          flex-grow-1 flex-shrink-1
        "
      >
        <div :style="driWidth">
          <div class="item-desc">
            <div
              class="
                desc-content desc-left
                d-flex
                flex-wrap flex-column
                align-start
              "
            >
              <div
                class="item-title d-flex align-end accent--text ma-0 pa-0 mb-5"
              >
                摂取できる栄養
                <div class="under-line line-right" />
              </div>
            </div>
          </div>
          <nutrients-achievement style="width: 100%" />
        </div>
      </v-col>
      <!-- DRI一覧 ここまで -->
    </v-row>
  </div>
</template>

<script>
import FoodCard from '../parts/FoodCard';
import NutrientsAchievement from '../parts/NutrientsAchievement';

export default {
  components: {
    FoodCard,
    NutrientsAchievement,
  },
  data() {
    return {
      suggestions: null,
      suggestionsExists: false,
      noneMessage: '存在しません',
      btnHeihgt: '30',
      btnWidth: '40%',
      btnWidthLarge: '209px',
    };
  },
  computed: {
    contentWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'sm':
          return 'max-width: 700px;';
        default:
          return 'max-width: 530px;';
      }
    },
    driWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'sm':
          return 'max-width: 700px;';
        default:
          return 'max-width: 650px;';
      }
    },
  },
  mounted() {
    this.setSuggestions();
  },
  methods: {
    createMealRecord() {
      this.axios
        .post('/api/v1/meal_records')
        .then((res) => {
          console.log(res.status);

          this.initializeSuggestions();
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '記録を作成しました',
          });

          this.$router.push({ name: 'HomePage' });
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    destroySuggestions() {
      this.axios
        .delete('/api/v1/suggestion')
        .then((res) => {
          console.log(res.status);
          this.initializeSuggestions();
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    reloadSuggestions() {
      this.axios
        .patch('/api/v1/suggestion')
        .then((res) => {
          console.log(res.status);
          const r = res.data;

          this.suggestionsExists = true;
          this.suggestions = r.meals;

          this.$store.dispatch('nutrientsAchievements/setAttributes', {
            totals: r.total,
            achvs: r.achv,
          });
        })
        .catch((e) => {
          console.error(e.response.status);
          const message = e.response.data.errors;

          this.$store.commit('flashMessage/setMessage', {
            type: 'error',
            message: `${message}`,
          });
        });
    },
    setSuggestions() {
      this.axios
        .get('/api/v1/suggestion')
        .then((res) => {
          console.log(res.status);
          const r = res.data;

          this.suggestionsExists = true;
          this.suggestions = r.meals;

          this.$store.dispatch('nutrientsAchievements/setAttributes', {
            totals: r.total,
            achvs: r.achv,
          });
        })
        .catch((e) => {
          console.error(e.response.status);
        });
    },
    initializeSuggestions() {
      this.suggestions = {};
      this.suggestionsExists = false;
    },
  },
};
</script>

<style scoped>
#bmr-and-dri {
  width: 100%;
}

.mypage-items {
  width: 100%;
}

.item-desc {
  width: 100%;
}

/* .desc-content {
  max-width: 240px;
} */

.desc-content.desc-left {
  position: relative;
  top: 0;
  left: 0;
}

.suggestions-placeholder {
  color: rgba(245, 245, 246, 0.5);
}

.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  position: relative;
  top: -6px;
}

.under-line.line-left {
  margin-right: 5px;
  width: 18px;
}

.under-line.line-right {
  margin-left: 5px;
  width: 18px;
}

.under-line.line-right-long {
  margin-left: 5px;
  width: 90px;
}

.under-line.line-vertical {
  border-color: rgba(245, 245, 246, 0.4);
  position: relative;
  top: 0px;
  left: 0;
  transform: rotate(90deg);
  width: 15px;
}

.v-btn.confirm-btn {
  text-transform: none !important;
}
</style>
