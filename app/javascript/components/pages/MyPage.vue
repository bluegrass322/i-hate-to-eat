<template>
  <v-container class="container">
    <v-tabs background-color="primary" color="base" dark grow>
      <v-tab> 栄養摂取基準設定 </v-tab>
      <v-tab> アカウント設定 </v-tab>
      <v-tab> 退会 </v-tab>

      <v-tab-item class="tab-item">
        <v-row>
          <v-col cols="12" md="4" class="mypage-items">
            <bmr-form @click="updateBmrAndReference" />
          </v-col>
          <v-col cols="12" md="4" class="mypage-items">
            <my-page-dri-index />
          </v-col>
        </v-row>
      </v-tab-item>
      <v-tab-item class="tab-item">
        <my-page-account-form />
      </v-tab-item>
      <v-tab-item class="tab-item">
        <p>comming soon...</p>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
import BmrForm from '../parts/BmrForm';
import MyPageDriIndex from '../parts/MyPageDriIndex';
import MyPageAccountForm from '../parts/MyPageAccountForm';

export default {
  components: {
    BmrForm,
    MyPageDriIndex,
    MyPageAccountForm,
  },
  mounted() {
    this.setData();
  },
  methods: {
    // BMRフォーム用のメソッド
    setData() {
      this.axios
        .get('/api/v1/mypage')
        .then((res) => {
          console.log(res.status);

          const r = res.data;
          this.dispatchBmr(r.bmr_params);
          this.dispatchPfc(r.pfc_params);
          this.dispatchDri(r.dri_params);
        })
        .catch((e) => {
          console.log(e.response.status);
        });
    },
    dispatchBmr(params) {
      this.$store.dispatch('bmrParams/setAttributes', params);
    },
    dispatchPfc(params) {
      this.$store.dispatch('pfcBalance/setAttributes', params);
    },
    dispatchDri(params) {
      this.$store.dispatch('referenceIntakes/setAttributes', params);
    },
    // TODO: 要リファクタリング
    updateBmrAndReference() {
      this.axios
        .patch('/api/v1/bmr', { user: this.$store.state.bmrParams.user })
        .then((res) => {
          console.log(res.status);

          this.$store.commit('bmrParams/updateBmr', res.data.bmr);
          this.dispatchPfc(res.data.pfc_params);

          // TODO: genderまたはbirthの値に変更がある時のみ実行するよう
          this.updateReferenceIntake();
        })
        .catch((error) => {
          let e = error.response;
          console.error(e.status);

          if (e.data.errors) {
            this.railsErrors.errorMessages = e.data.errors;
          }
          if (this.railsErrors.errorMessages.length != 0) {
            this.railsErrors.show = true;
            setTimeout(() => {
              this.railsErrors.show = false;
            }, 5000);
          }
        });
    },
    updateReferenceIntake() {
      this.axios
        .patch('/api/v1/users_dietary_reference_intake')
        .then((res) => {
          console.log(res.status);

          this.$store.dispatch(
            'referenceIntakes/setAttributes',
            res.data.data.attributes
          );
        })
        .catch((error) => {
          let e = error.response;
          console.error(e.status);

          if (e.data.errors) {
            this.railsErrors.errorMessages = e.data.errors;
          }
          if (this.railsErrors.errorMessages.length != 0) {
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
.container {
  margin: 0;
  padding: 0;
}

.mypage-items {
  margin-bottom: 30px;
}

.tab-item {
  background-color: #f5f5f6;
  padding: 30px 25px;
}
</style>
