<template>
  <v-card id="register-form" color="primary" flat tile>
    <v-card-title>
      <div class="text-h6 base--text">新規ユーザー登録</div>
    </v-card-title>
    <v-form @submit.prevent="createUser">
      <v-card-text>
        <template v-if="railsErrors.show">
          <v-alert class="text-center" dense type="error">
            <template v-for="e in railsErrors.errorMessages">
              <p :key="e">{{ e }}</p>
            </template>
          </v-alert>
        </template>
        <v-text-field
          v-model="user.name"
          color="base"
          dark
          type="text"
          label="ユーザーネーム"
        />
        <v-text-field
          v-model="user.email"
          color="base"
          dark
          type="email"
          label="メールアドレス"
        />
        <v-text-field
          v-model="user.password"
          color="base"
          dark
          type="password"
          label="パスワード"
        />
        <v-text-field
          v-model="user.password_confirmation"
          color="base"
          dark
          type="password"
          label="パスワード（確認）"
        />
      </v-card-text>
      <v-card-actions>
        <v-btn type="submit" color="base" outlined>登録</v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      birthInput: false,
      railsErrors: {
        show: false,
        message: '',
        errorMessages: [],
      },
    };
  },
  methods: {
    createUser() {
      this.axios
        .post('api/v1/registration', { user: this.user })
        .then((res) => {
          console.log(res.status);

          this.$store.commit('flashMessage/setMessage', {
            type: 'success',
            message: '登録に成功しました',
          });

          // TODO: 遷移先を一時的にTopに、後に修正
          this.$router.push({ name: 'TopPage' });
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
#register-form {
  margin: 30px 40px;
}

.actions {
  text-align: center;
}
</style>
