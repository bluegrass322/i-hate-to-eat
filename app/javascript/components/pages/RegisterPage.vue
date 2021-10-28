<template>
  <v-container id="register-form">
    <div class="text-h6 base--text">新規ユーザー登録</div>
    <validation-observer ref="observer" v-slot="{ handleSubmit }">
      <v-form @submit.prevent="handleSubmit(createUser)">
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
              v-model="user.name"
              :error-messages="errors"
              color="base"
              dark
              type="text"
              label="ユーザーネーム"
              required
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
              color="base"
              dark
              type="email"
              label="メールアドレス"
              required
            />
          </validation-provider>
          <v-radio-group
            v-model="user.gender"
            label="性別"
            dark
            row
            mandatory
            class="radio-group"
          >
            <div class="radio-btns">
              <v-radio color="base" label="女性" value="female" />
              <v-radio color="base" label="男性" value="male" />
            </div>
          </v-radio-group>
          <v-menu v-model="birthInput" :close-on-content-click="false">
            <template #activator="{ on }">
              <validation-provider
                v-slot="{ errors }"
                name="生年月日"
                rules="required|abailable_age"
              >
                <v-text-field
                  v-model="user.birth"
                  :error-messages="errors"
                  color="base"
                  dark
                  label="生年月日"
                  type="date"
                  readonly
                  v-on="on"
                />
              </validation-provider>
            </template>
            <v-date-picker v-model="user.birth" @input="birthInput = false" />
          </v-menu>
          <validation-provider
            v-slot="{ errors }"
            name="パスワード"
            rules="alpha_num|min:5|required"
            vid="confirmation"
          >
            <v-text-field
              v-model="user.password"
              :error-messages="errors"
              color="base"
              dark
              type="password"
              label="パスワード"
              required
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
              color="base"
              dark
              type="password"
              label="パスワード（確認）"
              required
            />
          </validation-provider>
          <v-btn type="submit" color="base" outlined tile small width="120">登録</v-btn>
      </v-form>
    </validation-observer>
  </v-container>
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
#register-form {
  padding: 40px 25px 30px 25px;
  text-align: center;
}

.actions {
  text-align: center;
}

.v-text-field {
  max-width: 350px;
}

.radio-btns {
  display: flex;
}
</style>
