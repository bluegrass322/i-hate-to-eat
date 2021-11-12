<template>
  <div id="suggestions-page" class="mx-9 my-9 pa-0">
    <v-row class="text-body-1 accent--text">
      <!-- 食材一覧 ここから -->
      <v-col cols="12" md="6" class="suggestions-item pa-0">
        <div class="cutting-line font-weight-bold pt-3 pb-2 pl-4">
          本日の食材
        </div>

        <div v-if="suggestionsExists" class="suggestion-item">
          <food-card :suggestions="suggestions" />
          <div class="arrow-text text-subtitle-2 my-7">食べてみますか？</div>
          <div class="d-flex flex-wrap justify-center align-center">
            <v-btn
              color="accent"
              dark
              :height="btnHeihgt"
              small
              tile
              outlined
              :width="btnWidth"
              class="confirm-btn"
              @click.stop="destroySuggestions()"
            >
              キャンセル
            </v-btn>
            <v-btn
              color="accent"
              dark
              :height="btnHeihgt"
              small
              tile
              outlined
              :width="btnWidth"
              class="confirm-btn"
              @click.stop="createMealRecord()"
            >
              食べる
            </v-btn>
          </div>
        </div>
        <div
          v-else
          class="
            suggestions-placeholder
            d-flex
            justify-center
            align-center
            text-body-2
            accent--text
          "
        >
          <div>{{ noneMessage }}</div>
        </div>
      </v-col>
      <!-- 食材一覧 ここまで -->

      <!-- 栄養素合計 ここから -->
      <v-col cols="12" md="6" class="suggestions-item mt-7 mt-md-0 pa-0">
        <div class="cutting-line font-weight-bold pt-3 pb-2 pl-4">
          摂取できる栄養
        </div>
        <nutrients-achievement />
      </v-col>
      <!-- 栄養素合計 ここまで -->
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
      btnHeihgt: '45',
    };
  },
  computed: {
    btnWidth() {
      switch (this.$vuetify.breakpoint.name) {
      case 'xs':
        return '100%';
      default:
        return '50%';
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
.v-btn.confirm-btn {
  color: white;
  background-color: rgba(90, 120, 153, 0.3);
  border: 1.5px solid #f5f5f6;
  box-sizing: border-box;
  text-transform: none !important;
}

#suggestions-page {
  width: 100%;
}

.arrow-text {
  text-align: center;
  vertical-align: middle;
}

.cutting-line {
  border-bottom: 1px dashed rgba(245, 245, 246, 1);
}

.meal-menus {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.foods-card-contents {
  padding: 8px 8px;
}

.suggestions-item {
  border: 2px solid rgba(245, 245, 246, 1);
}

.suggestions-placeholder {
  height: 150px;
}

.tabs {
  border-right: 1px solid #f5f5f6;
  border-bottom: 1px solid #f5f5f6;
  border-top: 1px solid #f5f5f6;
}

.tabs-end {
  border-bottom: 1px solid #f5f5f6;
  border-top: 1px solid #f5f5f6;
}
</style>
