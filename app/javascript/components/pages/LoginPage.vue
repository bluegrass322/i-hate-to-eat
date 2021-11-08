<template>
  <div id="login-form" class="d-block mx-7 my-10 pa-0">
    <div class="form-title mb-8">
      <span class="text-h6 accent--text">ログイン</span>
    </div>

    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(loginUser)">
        <template v-if="railsErrors.show">
          <template v-for="e in railsErrors.errorMessages">
            <v-alert
              :key="e"
              class="text-center text-body-2 text-sm-body-1"
              dense
              type="error"
            >
              {{ e }}
            </v-alert>
          </template>
        </template>

        <validation-provider
          v-slot="{ errors }"
          name="ユーザーネーム"
          rules="required"
        >
          <v-text-field
            v-model="name"
            :error-messages="errors"
            dark
            dense
            type="text"
            label="ユーザーネーム"
            outlined
            single-line
            prepend-inner-icon="mdi-account-outline"
            required
            class="form-item mb-1"
          />
        </validation-provider>
        <validation-provider
          v-slot="{ errors }"
          name="パスワード"
          rules="alpha_num|min:5|required"
          vid="confirmation"
        >
          <v-text-field
            v-model="password"
            :error-messages="errors"
            dark
            dense
            type="password"
            label="パスワード"
            outlined
            single-line
            prepend-inner-icon="mdi-lock-outline"
            required
            class="form-item mb-1"
          />
        </validation-provider>
        <v-btn
          type="submit"
          color="rgba(245, 245, 246, 0.7)"
          tile
          outlined
          width="240"
          class="mt-2"
          >ログイン</v-btn
        >
      </v-form>
    </validation-observer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: '',
      password: '',
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
    };
  },
  methods: {
    loginUser() {
      this.axios
        .post('api/v1/authentication', {
          name: this.name,
          password: this.password,
        })
        .then((response) => {
          console.log(response.status);

          this.$store.commit('authUser/login', response.data);
          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: 'ログインしました',
          });

          this.$router.push({ name: 'HomePage' });
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
.v-text-field {
  max-width: 350px;
  padding: 0;
}

.v-input.form-item {
  margin: 0 auto;
}

#login-form {
  text-align: center;
}
</style>
