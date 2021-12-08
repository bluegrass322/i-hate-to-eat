<template>
  <div id="bmr-and-dri">
    <v-row class="mt-12">
      <!-- BMRフォーム ここから -->
      <v-col
        cols="12"
        md="6"
        class="mypage-items d-flex flex-column align-center mb-15 mb-md-0 pa-0"
      >
        <div class="item-desc">
          <div
            class="
              desc-content desc-right
              d-flex
              flex-wrap flex-column
              align-start
            "
          >
            <div
              class="item-title d-flex align-end accent--text ma-0 pa-0 mb-5"
            >
              <div class="under-line line-left" />
              BMR設定
            </div>
            <div class="text-caption">
              以下のフォームから、1日に必要な最低限のエネルギー量（BMR）を計算します。
            </div>
          </div>
        </div>
        <div class="under-line-spacer line-long mt-8 mb-9" />
        <bmr-form @click="updateBmrAndReference" />
      </v-col>
      <!-- BMRフォーム ここまで -->

      <!-- DRI一覧 ここから -->
      <v-col
        cols="12"
        md="6"
        class="
          mypage-items
          d-flex
          flex-column
          align-center
          ma-0
          mt-16 mt-md-0
          pa-0
        "
      >
        <div class="item-desc" :style="driWidth">
          <div
            class="
              desc-content desc-left
              d-flex
              flex-wrap flex-column
              align-start
            "
          >
            <div class="item-title d-flex align-end accent--text pa-0 mb-5">
              あなたの栄養摂取基準
              <div class="under-line line-right" />
            </div>
            <div class="text-caption">
              厚生労働省制定の「日本人の食事摂取基準（2020年版）」をもとに、栄養素ごとの摂取目標量/日が設定されます。
            </div>
          </div>
        </div>
        <div class="under-line-spacer line-long mt-8 mb-9" :style="driWidth" />
        <my-page-setting-dri-index class="dri-index" :style="driWidth" />
      </v-col>
      <!-- DRI一覧 ここまで -->
    </v-row>
  </div>
</template>

<script>
import BmrForm from './BmrForm';
import MyPageSettingDriIndex from './MyPageSettingDriIndex';

export default {
  components: {
    BmrForm,
    MyPageSettingDriIndex,
  },
  computed: {
    driWidth() {
      switch (this.$vuetify.breakpoint.name) {
        case 'lg':
        case 'xl':
          return 'max-width: 650px;';
        default:
          return 'max-width: 350px;';
      }
    },
  },
  mounted() {
    this.setData();
  },
  methods: {
    setData() {
      this.axios
        .get('/api/v1/mypage')
        .then((res) => {
          console.log(res.status);

          const r = res.data;
          this.dispatchBmr(r.bmr_params);
          this.dispatchDri(r.dri_params);
          // this.dispatchPfc(r.pfc_params);
        })
        .catch((e) => {
          console.log(e.response.status);
        });
    },
    dispatchBmr(params) {
      this.$store.dispatch('bmrParams/setStates', params);
    },
    dispatchDri(params) {
      this.$store.dispatch('referenceIntakes/setStates', params);
    },
    // 現時点では未使用のため一旦コメントアウト
    // dispatchPfc(params) {
    //   this.$store.dispatch('pfcBalance/setStates', params);
    // },
    updateBmrAndReference() {
      this.axios
        .patch('/api/v1/bmr', { user: this.$store.state.bmrParams.user })
        .then((res) => {
          console.log(res.status);

          this.$store.commit('bmrParams/updateBmr', res.data.bmr);

          const dri = JSON.parse(res.data.dri);
          this.$store.dispatch(
            'referenceIntakes/setStates',
            dri.data.attributes
          );

          // this.dispatchPfc(res.data.pfc_params);
        })
        .catch((error) => {
          console.error(error.response.status);

          let e = error.response.data.errors;
          if (e && e.length != 0) {
            this.railsErrors.errorMessages = e;
            this.railsErrors.show = true;

            setTimeout(() => {
              this.railsErrors.show = false;
            }, 5000);
          }
        });
    },
  },
};
</script>

<style scoped>
.mypage-items {
  width: 100%;
}

.item-desc {
  width: 100%;
  max-width: 350px;
}

.desc-content {
  max-width: 240px;
}

.desc-content.desc-right {
  margin-left: auto;
  position: relative;
  top: 0;
  left: 10px;
}

.desc-content.desc-left {
  margin-right: auto;
  position: relative;
  top: 0;
  left: 0;
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

.under-line-spacer {
  border-bottom: 1px solid rgb(245, 245, 246);
  width: 15px;
}

.under-line-spacer.line-long {
  width: 100%;
  max-width: 350px;
}
</style>
