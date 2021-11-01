<template>
  <v-container class="container">
    <v-row  v-if="suggestionsExists" class="suggestion-row">
      <v-col cols="12" md="6" class="pa-0">
        <div class="suggestion-item">
          <div class="base--text suggestion-items-title">
            <span class="suggestion-items-title-text">Today's meal</span>
          </div>
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
                  <v-card-actions>
                    <v-btn
                      color="base"
                      dark
                      text
                      outlined
                      small
                      @click.stop="
                        setFoodDetails(f.food_category_id, f.id);
                        showDetail = true;
                      "
                    >
                      詳細
                    </v-btn>
                    <v-dialog v-model="showDetail" scrollable>
                      <food-detail />
                    </v-dialog>
                  </v-card-actions>
                </v-card>
              </v-sheet>
            </template>
            <div>
              <v-btn
                color="base"
                dark
                text
                outlined
                small
                @click.stop="createMealRecord()"
              >
                食べる
              </v-btn>
              <v-btn
                color="base"
                dark
                text
                outlined
                small
                @click.stop="destroySuggestions()"
              >
                食べない
              </v-btn>
            </div>
          </div>
        </div>
      </v-col>
      <v-col cols="12" md="6" class="pa-0">
        <div>
          <nutrients-achievement />
        </div>
      </v-col>
    </v-row>
    <v-row v-else class="none-message">
      <div class="none-menus base--text">
        <span>{{ noneMessage }}</span>
      </div>
    </v-row>
  </v-container>
</template>

<script>
import foodDetail from '../parts/FoodDetail';
import NutrientsAchievement from '../parts/NutrientsAchievement';

export default {
  components: {
    foodDetail,
    NutrientsAchievement,
  },
  data() {
    return {
      suggestions: {},
      suggestionsExists: false,
      showDetail: false,
      noneMessage: '本日の食事メニューは存在しません',
    };
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
    setFoodDetails(categoryId, foodId) {
      this.axios
        .get(`/api/v1/food_categories/${categoryId}/foods/${foodId}`)
        .then((res) => {
          console.log(res.status);
          this.$store.dispatch(
            'foodDetails/setAttributes',
            res.data.data.attributes
          );
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
.container {
  margin: 0;
  padding: 0;
}

.none-message {
  margin: 30px 20px;
}

.suggestion-row {
  background-color: #5a7899;
  margin: 30px 20px;
}

.suggestion-item {
  margin-bottom: 40px;
}

.suggestion-items-title {
  border-bottom: 1px solid #f5f5f6;
  height: 48px;
  margin-bottom: 15px;
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
