<template>
  <v-row id="register-form" class="d-block mx-7 my-10 pa-0">
    <div class="form-title mb-8">
      <span class="text-h6 accent--text">新規ユーザー登録</span>
    </div>

    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(createUser)">
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
            v-model="user.name"
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
          name="メールアドレス"
          rules="email|required"
        >
          <v-text-field
            v-model="user.email"
            :error-messages="errors"
            dark
            dense
            type="email"
            label="メールアドレス"
            outlined
            single-line
            required
            prepend-inner-icon="mdi-email-outline"
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
            v-model="user.password"
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
        <validation-provider
          v-slot="{ errors }"
          name="パスワード（確認）"
          rules="confirmed:confirmation|required"
        >
          <v-text-field
            v-model="user.password_confirmation"
            :error-messages="errors"
            dark
            dense
            type="password"
            label="パスワード（確認）"
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
          >登録</v-btn
        >
      </v-form>
    </validation-observer>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: '',
        email: '',
        gender: '',
        birth: '',
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
.v-text-field {
  max-width: 350px;
  padding: 0;
}

.v-input.form-item {
  margin: 0 auto;
}

#register-form {
  text-align: center;
}
</style>
