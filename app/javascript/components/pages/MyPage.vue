<template>
  <v-container class="container">
    <v-tabs background-color="primary" color="base" dark>
      <v-tab> 栄養摂取基準設定 </v-tab>
      <v-tab> アカウント設定 </v-tab>
      <v-tab> 退会 </v-tab>

      <v-tab-item class="tab-item">
        <v-row>
          <v-col cols="12" md="4">
            <bmr-form @click="updateBmrAndReference" />
          </v-col>
        </v-row>
      </v-tab-item>
      <v-tab-item class="tab-item">
        <p>comming soon...</p>
      </v-tab-item>
      <v-tab-item class="tab-item">
        <p>comming soon...</p>
      </v-tab-item>
    </v-tabs>
  </v-container>
</template>

<script>
import BmrForm from '../parts/BmrForm';

export default {
  components: {
    BmrForm,
  },
  mounted() {
    this.setData();
  },
  methods: {
    setData() {
      this.axios.get('/api/v1/bmr').then((response) => {
        this.$store.dispatch('bmrParams/setAttributes', response.data);
      });
    },
    updateBmrAndReference() {
      this.updateBmr();
    },
    updateBmr() {
      this.axios
        .patch('/api/v1/bmr', { user: this.$store.state.bmrParams.user })
        .then((response) => {
          console.log(response.status);
          this.$store.commit('bmrParams/updateBmr', response.data.bmr);
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

.tab-item {
  background-color: #f5f5f6;
  padding: 30px 25px;
}
</style>
