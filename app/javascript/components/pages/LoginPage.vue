<template>
  <v-card id="login-form" color="primary" flat tile>
    <v-card-title>
      <div class="text-h6 base--text">ログイン</div>
    </v-card-title>
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(loginUser)">
        <v-card-text>
          <template v-if="railsErrors.show">
            <v-alert class="text-center" dense type="error">
              <template v-for="e in railsErrors.errorMessages">
                <p :key="e">{{ e }}</p>
              </template>
            </v-alert>
          </template>
          <validation-provider
            v-slot="{ errors }"
            name="ユーザーネーム"
            rules="required"
          >
            <v-text-field
              v-model="name"
              :error-messages="errors"
              color="base"
              dark
              type="name"
              label="ユーザーネーム"
              required
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
              color="base"
              dark
              type="password"
              label="パスワード"
              required
            />
          </validation-provider>
        </v-card-text>
        <v-card-actions>
          <v-btn type="submit" color="base" outlined>ログイン</v-btn>
        </v-card-actions>
      </v-form>
    </validation-observer>
  </v-card>
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
#login-form {
  margin: 30px 40px;
}

.actions {
  text-align: center;
}
</style>
