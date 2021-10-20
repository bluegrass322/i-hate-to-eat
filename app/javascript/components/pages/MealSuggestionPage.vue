<template>
  <v-container class="container">
    <v-row class="suggestion-row">
      <v-col cols="12" md="6" class="pa-0">
        <div class="suggestion-item">
          <div class="base--text suggestion-items-title">
            <span class="suggestion-items-title-text">Today's meal</span>
          </div>
          <div class="meal-menus">
            <template
              v-for="f in suggestions"
            >
              <v-sheet :key="f.id" color="base" class="foods-card">
                <v-card
                  flat
                  tile
                  color="primary"
                  height="60"
                  width="130"
                  class="foods-card-contents"
                >
                  <v-card-text class="pa-0 text-caption text-center base--text">
                    <div class="font-weight-medium">
                      {{ f.name }} {{ f.subname }}
                    </div>
                    <div>
                      {{ f.reference_amount * 100 }}g
                    </div>
                  </v-card-text>
                </v-card>
              </v-sheet>
            </template>
          </div>
        </div>
      </v-col>
      <v-col cols="12" md="6" class="pa-0">
        <div>
          <nutrients-achievement />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import NutrientsAchievement from '../parts/NutrientsAchievement';

export default {
  components: {
    NutrientsAchievement
  },
  data() {
    return {
      suggestions: {}
    };
  },
  mounted() {
    this.setSuggestions();
  },
  methods: {
    setSuggestions() {
      this.axios
        .get('/api/v1/suggestion')
        .then(res => {
          console.log(res.status);
          const r = res.data;

          this.suggestions = r.meals;
          this.$store.dispatch(
            'nutrientsAchievements/setAttributes',
            {
              totals: r.total,
              achvs: r.achv,
            }
          );
        })
        .catch(e => {
          console.error(e);
        });
    }
  }
};
</script>

<style scoped>
.container {
  margin: 0;
  padding: 0;
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