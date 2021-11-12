<template>
  <div>
    <v-row>
      <v-col cols="12" md="6" class="mypage-items">
        <bmr-form @click="updateBmrAndReference" />
      </v-col>
      <v-col cols="12" md="6" class="mypage-items">
        <my-page-dri-index />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import BmrForm from './BmrForm';
import MyPageDriIndex from './MyPageDriIndex';

export default {
  components: {
    BmrForm,
    MyPageDriIndex,
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
}
</script>