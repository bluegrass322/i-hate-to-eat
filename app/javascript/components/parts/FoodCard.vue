<template>
  <div id="suggested-foods" class="d-flex flex-wrap">
    <template v-for="f in suggestions">
      <v-sheet :key="f.id" color="#a3b0c1" :width="cardWidth" outlined>
        <v-card
          color="secondary"
          flat
          tile
          :height="cardHeight"
          class="d-flex flex-column justify-center pa-0"
        >
          <v-card-text
            class="
              card-text
              d-flex
              flex-column
              justify-center
              align-center
              pa-0
              accent--text
              text-caption
            "
          >
            <div class="font-weight-medium text-body-2">
              {{ f.name }}
            </div>
            <div>{{ f.subname }}</div>
            <div>{{ f.reference_amount * 100 }}g</div>
          </v-card-text>
          <v-card-actions class="actions pa-0">
            <v-btn
              color="secondary"
              depressed
              tile
              height="30"
              :width="btnWidth"
              class="detail-btn"
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
  </div>
</template>

<script>
import FoodDetail from '../parts/FoodDetail';

export default {
  components: {
    FoodDetail,
  },
  props: {
    suggestions: {
      type: Array,
      default: null,
      required: false,
    },
  },
  data() {
    return {
      showDetail: false,
      cardHeight: 110,
      btnWidth: '100%',
    };
  },
  computed: {
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
  methods: {
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
  },
};
</script>

<style scoped>
.v-btn.detail-btn {
  color: rgba(78, 102, 129, 1);
}

.actions {
  border-top: 1px solid rgba(245, 245, 246, 0.6);
  margin-top: auto;
  width: 100%;
}

.card-text {
  margin-top: auto;
}
</style>
