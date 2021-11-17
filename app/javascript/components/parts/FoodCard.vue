<template>
  <div id="suggested-foods" class="d-flex flex-wrap">
    <template v-for="f in suggestions">
      <v-sheet :key="f.id" color="#f5f5f6" :width="cardWidth" outlined>
        <v-card
          color="back"
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
              py-4
              accent--text
              text-caption
            "
          >
            <div class="font-weight-bold text-caption text-md-body-2">
              {{ f.name }}
            </div>
            <div class="text-caption font-weight-bold mb-2">
              {{ f.subname }}
            </div>
            <div class="text-caption">{{ f.reference_amount * 100 }}g</div>
          </v-card-text>
          <v-card-actions class="actions pa-0">
            <v-btn
              color="accent"
              depressed
              tile
              height="25"
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
            <v-dialog v-model="showDetail" max-width="400" scrollable>
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
      cardHeight: 145,
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
.actions {
  margin-top: auto;
  width: 100%;
}

.card-text {
  margin-top: auto;
}

.v-btn.detail-btn {
  background-color: rgb(55, 56, 56) !important;
  border-top: 1.5px solid #f5f5f6;
  box-sizing: border-box;
}
</style>
